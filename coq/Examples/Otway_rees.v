(** Protocol: otway-rees (otway_rees.scm:7:1) *)

Require Import Proc.
Import List.ListNotations.
Open Scope list_scope.
Open Scope string.

(** Role: init (otway_rees.scm:9:3) *)

Definition init: proc :=
  mkProc
  [(0, Chan); (1, Name); (2, Name); (3, Skey)]
  [
   (* Send (otway_rees.scm:12:6) *)
   Bind (4, Text) (Frsh_);
   Bind (5, Mesg) (Pair_ 2 4);
   Bind (6, Mesg) (Pair_ 1 5);
   Send 0 6;
   (* Recv (otway_rees.scm:13:6) *)
   Bind (7, Mesg) (Recv_ 0);
   Bind (8, Mesg) (Decr_ 7 3);
   Bind (9, Text) (Frst_ 8);
   Bind (10, Mesg) (Scnd_ 8);
   Same 9 4;
   Bind (11, Name) (Frst_ 10);
   Bind (12, Mesg) (Scnd_ 10);
   Same 11 1;
   Bind (13, Name) (Frst_ 12);
   Bind (14, Skey) (Scnd_ 12);
   Same 13 2;
   Return [14]
  ].

(** Role: resp (otway_rees.scm:20:3) *)

Definition resp: proc :=
  mkProc
  [(0, Chan); (1, Chan); (2, Name); (3, Skey)]
  [
   (* Recv (otway_rees.scm:24:6) *)
   Bind (4, Mesg) (Recv_ 0);
   Bind (5, Name) (Frst_ 4);
   Bind (6, Mesg) (Scnd_ 4);
   Bind (7, Name) (Frst_ 6);
   Bind (8, Text) (Scnd_ 6);
   Same 7 2;
   (* Send (otway_rees.scm:25:6) *)
   Bind (9, Text) (Frsh_);
   Bind (10, Mesg) (Pair_ 8 9);
   Bind (11, Mesg) (Pair_ 2 10);
   Bind (12, Mesg) (Pair_ 5 11);
   Send 1 12;
   (* Recv (otway_rees.scm:26:6) *)
   Bind (13, Mesg) (Recv_ 1);
   Bind (14, Mesg) (Frst_ 13);
   Bind (15, Mesg) (Scnd_ 13);
   Bind (16, Mesg) (Decr_ 15 3);
   Bind (17, Text) (Frst_ 16);
   Bind (18, Mesg) (Scnd_ 16);
   Same 17 9;
   Bind (19, Name) (Frst_ 18);
   Bind (20, Mesg) (Scnd_ 18);
   Same 19 5;
   Bind (21, Name) (Frst_ 20);
   Bind (22, Skey) (Scnd_ 20);
   Same 21 2;
   (* Send (otway_rees.scm:27:6) *)
   Send 0 14;
   Return [5; 22]
  ].

(** Role: serv (otway_rees.scm:34:3) *)

Definition serv: proc :=
  mkProc
  [(0, Chan); (1, Name); (2, Name); (3, Skey); (4, Skey)]
  [
   (* Recv (otway_rees.scm:37:6) *)
   Bind (5, Mesg) (Recv_ 0);
   Bind (6, Name) (Frst_ 5);
   Bind (7, Mesg) (Scnd_ 5);
   Same 6 1;
   Bind (8, Name) (Frst_ 7);
   Bind (9, Mesg) (Scnd_ 7);
   Same 8 2;
   Bind (10, Text) (Frst_ 9);
   Bind (11, Text) (Scnd_ 9);
   (* Send (otway_rees.scm:38:6) *)
   Bind (12, Skey) (Frsh_);
   Bind (13, Mesg) (Pair_ 2 12);
   Bind (14, Mesg) (Pair_ 1 13);
   Bind (15, Mesg) (Pair_ 10 14);
   Bind (16, Mesg) (Encr_ 15 3);
   Bind (17, Mesg) (Pair_ 11 14);
   Bind (18, Mesg) (Encr_ 17 4);
   Bind (19, Mesg) (Pair_ 16 18);
   Send 0 19;
   Return [12]
  ].
