(** * Representation of Generated Code *)

Require Export String List.

(** A procedure variable is a nat *)

Notation pvar := nat (only parsing).

(** Types *)

Inductive type: Set :=
| Text
| Data
| Name
| Skey
| Akey
| Ikey
| Mesg
| Chan.

Definition type_dec:
  forall x y: type, {x = y} + {x <> y}.
Proof.
  intros.
  decide equality.
Defined.
#[global]
Hint Resolve type_dec : core.

Definition type_eqb x y: bool :=
  if type_dec x y then
    true
  else
    false.

Lemma type_eq_correct:
  forall x y,
    type_eqb x y = true <-> x = y.
Proof.
  intros.
  unfold type_eqb.
  destruct (type_dec x y); subst; intuition.
  inversion H.
Qed.

Lemma type_eq_complete:
  forall x y,
    type_eqb x y = false <-> x <> y.
Proof.
  intros.
  unfold type_eqb.
  destruct (type_dec x y); subst; intuition.
Qed.

(** The inverse type *)

Definition inv_type (x: type): type :=
  match x with
  | Akey => Ikey
  | Ikey => Akey
  | s => s
  end.

(** Declarations *)

Definition decl: Set := pvar * type.

Definition decl_dec:
  forall x y: decl, {x = y} + {x <> y}.
Proof.
  intros.
  decide equality; decide equality.
Defined.
#[global]
Hint Resolve decl_dec : core.

(** Expressions *)
Inductive expr: Set :=
| Tagg: string -> expr          (* Construct a tag *)
| Hash: pvar -> expr            (* Construct a hash *)
| Pair: pvar -> pvar -> expr    (* Construct a pair *)
| Encr: pvar -> pvar -> expr    (* Encrypt plain text *)
| Frst: pvar -> expr            (* Project first component of pair *)
| Scnd: pvar -> expr            (* Project second component of pair *)
| Decr: pvar -> pvar -> expr    (* Decrypt cipher text *)
| Nonce: expr                   (* Generate a nonce *)
| Recv:  pvar -> expr.          (* Receive a message *)

(** Statements *)

Inductive stmt: Set :=
| Return: list pvar -> stmt     (* Return values *)
| Bind: decl -> expr -> stmt    (* Bind a variable *)
| Send: pvar -> pvar -> stmt    (* Send a message *)
| Same: pvar -> pvar -> stmt.   (* Check for sameness *)

(** Procedures *)

Record proc: Set :=
  mkProc {
      ins: list decl;
      body: list stmt }.