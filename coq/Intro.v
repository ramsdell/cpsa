(**

* Introduction

CPSA4 analyzes cryptographic protocols.  It allows its users to
determine if a protocol achieves authentication and secrecy goals.

Once a protocol is analyzed, there is the question of determining how
the analyzed protocol corresponds to its implementation.  One wants to
be confident that the implemented protocol achieves the authentication
and secrecy goals determined by CPSA4.

Roletran is a compiler that translates roles in CPSA4 protocols into a
language independent description of procedures called Zappa
Intermediate Language (ZIL).  This Coq development is in support of
verifying the translation of CPSA4 roles into ZIL procedures.

The are three relevant Haskell programs: cpsa4roletran, cpsa4coq,
cpsa4rolecoq.  The Roletran compiler is call cpsa4roletran.  ZIL
procedures are translated into Coq using cpsa4coq.  CPSA4 roles are
translated into Coq using cpsa4rolecoq.  The roles extracted from the
Unilateral protocol are in library Unilateral_roles.  The procedures
generated by Roletran are in library Unilateral.  There are more
examples in the Examples directory.

** Road Map

Library Monad provides monadic operations on option types.  It
provides a Haskell-like do notation that makes it easier to define
partial functions.

Library Alg defines the message algebra.

Library Role defines a role and the properties in needs to be valid.

Library Derives defines the derivation relation.

Library Exec defines the notion of an executable role.

Library Proc defines what is need to interpret the output of cpsa4coq.
It defines the types used by the runtime system and the syntax of
statements.

Library Match defines what it means for one role to contain all of the
structure contained in another.

Library Sem defines the abstract execution semantics of procedures.

Library Alt_sem defines an alternate abstract execution semantics of
procedures that some people might find more intuitive.

Library Run defines the abstract execution semantics of procedures as
a Coq function.  When its inputs are known, it will compute the
results of executing a procedure.

Library Nonce defines a function that computes the correct order for
generating nonces during a run of a procedure.

Library Run_sem contains proofs that the semantics specified in Run
and Sem agree.

Library Sem_tactics defines tactics used to automate many proof.

Library CSem defines a concrete execution semantics in which
probabilistic encryption is simulated by adding an argument to
encryption that provides randomness.

Library Comp defines the Roletran compiler (Not up-to-date).

*)
