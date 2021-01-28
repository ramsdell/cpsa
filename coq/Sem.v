(** * Abstract Execution Semantics for Procedures

    This section provides the semantics of procedures generated by the
    role compiler. *)

Require Import ListSet Bool Program Monad Proc Alg.
Require Export Role Match.
Import List.ListNotations.
Open Scope list_scope.
Open Scope nat_scope.
(** printing <- #←# *)

(** A runtime environment *)

Definition env: Set := list (pvar * alg).

(** Check the type of an element of the message algebra. *)

Inductive type_check: type -> alg -> Prop :=
| Text_check: forall v,
    type_check Text (Tx v)
| Data_check: forall v,
    type_check Data (Dt v)
| Name_check: forall v,
    type_check Name (Nm v)
| Skey_check: forall k,
    type_check Skey (Sk k)
| Akey_check: forall k,
    type_check Akey (Ak k)
| Ikey_check: forall k,
    type_check Ikey (Ik k)
| Chan_check: forall v,
    type_check Chan (Ch v)
| Mesg_check: forall a,
    type_check Mesg a.
#[global]
Hint Constructors type_check : core.

(** The semantics of an expression

<<
   Parameters:
   env:      Input environment
   list evt: Input trace
   list alg: Input list of uniques
   expr:     Expression code fragment
   alg:      Value of the expression
   list evt: Output trace
   list alg: Output list of uniques
>>
*)

Inductive expr_sem: env -> list evt -> list alg -> expr ->
                    alg -> list evt -> list alg -> Prop :=
| Expr_tagg: forall ev tr us x,
    expr_sem ev tr us (Tagg x) (Tg x) tr us
| Expr_hash: forall ev tr us x a,
    lookup x ev = Some a ->
    expr_sem ev tr us (Hash x) (Hs a) tr us
| Expr_pair: forall ev tr us x y a b,
    lookup x ev = Some a ->
    lookup y ev = Some b ->
    expr_sem ev tr us (Pair x y) (Pr a b) tr us
| Expr_encr: forall ev tr us x y a b,
    lookup x ev = Some a ->
    lookup y ev = Some b ->
    expr_sem ev tr us (Encr x y) (En a b) tr us
| Expr_frst: forall ev tr us x a b,
    lookup x ev = Some (Pr a b) ->
    expr_sem ev tr us (Frst x) a tr us
| Expr_scnd: forall ev tr us x a b,
    lookup x ev = Some (Pr a b) ->
    expr_sem ev tr us (Scnd x) b tr us
| Expr_decr: forall ev tr us x y a b,
    lookup x ev = Some (En a b) ->
    lookup y ev = Some (inv b) ->
    expr_sem ev tr us (Decr x y) a tr us
| Expr_nonce: forall ev tr us a,
    expr_sem ev tr (a :: us) Nonce a tr us
| Expr_recv: forall ev tr us a c d,
    lookup c ev = Some (Ch d) ->
    expr_sem ev (Rv d a :: tr) us (Recv c) a tr us.
#[global]
Hint Constructors expr_sem : core.

(** The semantics of a statement

<<
   Parameters:
   env:      Input environment
   list evt: Input trace
   list alg: Input list of uniques
   stmt:     Statement
   env:      Output environment
   list evt: Output trace
   list alg: Output list of uniques
>>
*)

Inductive stmt_sem: env -> list evt -> list alg ->
                    stmt -> env -> list evt ->
                    list alg -> Prop :=
| Stmt_bind: forall ev tr us exp val v s tr' us',
    expr_sem ev tr us exp val tr' us' ->
    type_check s val ->
    stmt_sem ev tr us (Bind (v, s) exp) ((v, val) :: ev) tr' us'
| Stmt_send: forall ev tr us c d x a,
    lookup c ev = Some (Ch d) ->
    lookup x ev = Some a ->
    stmt_sem ev (Sd d a :: tr) us (Send c x) ev tr us
| Stmt_same: forall ev tr us x y a b,
    lookup x ev = Some a ->
    lookup y ev = Some b ->
    a = b ->                    (* Sameness check *)
    stmt_sem ev tr us (Same x y) ev tr us.
#[global]
Hint Constructors stmt_sem : core.

Lemma stmt_sem_env_extends:
  forall ev tr us cmd ev' tr' us',
    stmt_sem ev tr us cmd ev' tr' us' ->
    exists ev'', ev' = ev'' ++ ev.
Proof.
  intros.
  inversion H; subst.
  - exists [(v, val)]; auto.
  - exists []; auto.
  - exists []; auto.
Qed.

(** The semantics of a statement list

    Parameters as for [stmt_sem] but with one extra argument,
    for outputs.

<<
   Parameters:
   env:        Input environment
   list evt:   Input trace
   list alg:   Input list of uniques
   list alg:   Output list
   list stmt:  Statement list
   env:        Output environment
   list evt:   Output trace
   list alg:   Output list of uniques
>>
*)

Inductive stmt_list_sem: env -> list evt -> list alg ->
                         list alg -> list stmt -> env ->
                         list evt -> list alg -> Prop :=
| Stmt_return: forall ev outs vs,
    map_m (flip lookup ev) vs = Some outs ->
    stmt_list_sem ev [] [] outs [Return vs] ev [] []
| Stmt_pair: forall ev tr us outs stmt ev' tr' us' stmts ev'' tr'' us'',
    stmt_sem ev tr us stmt ev' tr' us' ->
    stmt_list_sem ev' tr' us' outs stmts ev'' tr'' us'' ->
    stmt_list_sem ev tr us outs (stmt :: stmts) ev'' tr'' us''.
#[global]
Hint Constructors stmt_list_sem : core.

Lemma stmt_list_sem_env_extends:
  forall ev tr us outs stmts ev' tr' us',
    stmt_list_sem ev tr us outs stmts ev' tr' us' ->
    exists ev'', ev' = ev'' ++ ev.
Proof.
  intros.
  induction H.
  exists []; auto.
  apply stmt_sem_env_extends in H.
  destruct H.
  destruct IHstmt_list_sem.
  subst.
  exists (x0 ++ x).
  apply app_assoc.
Qed.

(** Executions are roles with one exception.  The order in which
    uniques occur in an execution is significant, but it is not for a
    role.  In an execution, the order of the uniques determines the
    order in which they are used to generate nonces.  Within a role,
    uniques are just a set of basic values. *)

Fixpoint mk_env (ds: list decl) (xs: list alg): env :=
  match (ds, xs) with
  | ((v, _) :: ds, x :: xs) =>
    (v, x) :: mk_env ds xs
  | _ => []
  end.

Inductive ins_inputs: list decl -> list alg -> Prop :=
| Ins_inputs_nil: ins_inputs nil nil
| Ins_inputs_pair: forall v s ds x xs,
    type_check s x ->
    ins_inputs ds xs ->
    ins_inputs ((v, s) :: ds) (x :: xs).
#[global]
Hint Constructors ins_inputs : core.

(** The semantics of a procedure using statement lists *)

Definition sem (p: proc) (ev: env) (e: role): Prop :=
  let ev_in := mk_env (ins p) (inputs e) in
  ins_inputs (ins p) (inputs e) /\
  stmt_list_sem ev_in (trace e) (uniqs e) (outputs e) (body p) ev [] [].

(** ** Correct Input and Output *)

Definition correct_io_liveness (rl: role) (p: proc): Prop :=
  valid_role rl = true /\
  exists ev ex,
    inputs rl = inputs ex /\
    sem p ev ex /\
    homomorphism rl ex <> None /\
    homomorphism ex rl <> None.

Definition correct_io_safety (rl: role) (p: proc): Prop :=
  forall ev ex,
    inputs rl = inputs ex ->
    sem p ev ex ->
    homomorphism rl ex <> None.

(** Try using the role as the execution, but remember that the uniques
    are a set and list order might differ. *)

Lemma correct_io_liveness_aid:
  forall (rl: role) (p: proc),
    valid_role rl = true ->
    (exists ev ex uniqs,
        ex = mkRole (trace rl) uniqs (inputs rl) (outputs rl) /\
        sem p ev ex /\
        homomorphism rl ex <> None /\
        homomorphism ex rl <> None) ->
    correct_io_liveness rl p.
Proof.
  intros rl p G H.
  destruct H as [ev H].
  destruct H as [ex H].
  destruct H as [uniqs H].
  unfold correct_io_liveness.
  split; auto.
  destruct H.
  exists ev; exists ex.
  subst; auto.
Qed.