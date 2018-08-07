(herald "Woo-Lam Protocol")

(comment "CPSA 4.1.2")
(comment "All input read from woolam.scm")

(defprotocol woolam basic
  (defrole init
    (vars (a s name) (n text))
    (trace (send a) (recv n) (send (enc n (ltk a s))))
    (non-orig (ltk a s)))
  (defrole resp
    (vars (a s b name) (n text))
    (trace (recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc a n (ltk b s))))
    (non-orig (ltk b s))
    (uniq-orig n))
  (defrole serv
    (vars (a s b name) (n text))
    (trace (recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc a n (ltk b s))))))

(defskeleton woolam
  (vars (n text) (a s b name))
  (defstrand resp 5 (n n) (a a) (s s) (b b))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc a n (ltk b s)))))
  (label 0)
  (unrealized (0 2) (0 4))
  (origs (n (0 1)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton woolam
  (vars (n text) (a s b name))
  (defstrand resp 5 (n n) (a a) (s s) (b b))
  (defstrand init 3 (n n) (a a) (s s))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand init 3) (enc n (ltk a s))
    (0 2))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc a n (ltk b s))))
    ((send a) (recv n) (send (enc n (ltk a s)))))
  (label 1)
  (parent 0)
  (unrealized (0 4))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton woolam
  (vars (n text) (a s b name))
  (defstrand resp 5 (n n) (a a) (s s) (b b))
  (defstrand init 3 (n n) (a a) (s s))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (precedes ((0 1) (1 1)) ((0 1) (2 0)) ((1 2) (0 2)) ((2 1) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand serv 2) (enc a n (ltk b s))
    (0 4))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc a n (ltk b s))))
    ((send a) (recv n) (send (enc n (ltk a s))))
    ((recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc a n (ltk b s)))))
  (label 2)
  (parent 1)
  (unrealized (2 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton woolam
  (vars (n text) (a s b name))
  (defstrand resp 5 (n n) (a a) (s s) (b b))
  (defstrand init 3 (n n) (a a) (s s))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (precedes ((0 1) (1 1)) ((0 3) (2 0)) ((1 2) (0 2)) ((2 1) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (displaced 3 0 resp 4)
    (enc a (enc n (ltk a s)) (ltk b s)) (2 0))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc a n (ltk b s))))
    ((send a) (recv n) (send (enc n (ltk a s))))
    ((recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc a n (ltk b s)))))
  (label 3)
  (parent 2)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n))))
  (origs (n (0 1))))

(comment "Nothing left to do")

(defprotocol woolam-msg basic
  (defrole init
    (vars (a s name) (n text))
    (trace (send a) (recv n) (send (enc n (ltk a s))))
    (non-orig (ltk a s)))
  (defrole resp
    (vars (a s b name) (n text) (m mesg))
    (trace (recv a) (send n) (recv m) (send (enc a m (ltk b s)))
      (recv (enc n (ltk b s))))
    (non-orig (ltk b s))
    (uniq-orig n))
  (defrole serv
    (vars (a s b name) (n text))
    (trace (recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc n (ltk b s))))))

(defskeleton woolam-msg
  (vars (m mesg) (n text) (a s b name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (traces
    ((recv a) (send n) (recv m) (send (enc a m (ltk b s)))
      (recv (enc n (ltk b s)))))
  (label 4)
  (unrealized (0 4))
  (origs (n (0 1)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton woolam-msg
  (vars (m mesg) (n text) (a s b name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand init 3 (n n) (a b) (s s))
  (precedes ((0 1) (1 1)) ((1 2) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand init 3) (enc n (ltk b s))
    (0 4))
  (traces
    ((recv a) (send n) (recv m) (send (enc a m (ltk b s)))
      (recv (enc n (ltk b s))))
    ((send b) (recv n) (send (enc n (ltk b s)))))
  (label 5)
  (parent 4)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m m))))
  (origs (n (0 1))))

(defskeleton woolam-msg
  (vars (m mesg) (n text) (a s b a-0 name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a-0) (s s) (b b))
  (precedes ((0 1) (1 0)) ((1 1) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand serv 2) (enc n (ltk b s))
    (0 4))
  (traces
    ((recv a) (send n) (recv m) (send (enc a m (ltk b s)))
      (recv (enc n (ltk b s))))
    ((recv (enc a-0 (enc n (ltk a-0 s)) (ltk b s)))
      (send (enc n (ltk b s)))))
  (label 6)
  (parent 4)
  (unrealized (1 0))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton woolam-msg
  (vars (n text) (a s b name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (precedes ((0 3) (1 0)) ((1 1) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (displaced 2 0 resp 4)
    (enc a-0 (enc n (ltk a-0 s)) (ltk b s)) (1 0))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc n (ltk b s))))
    ((recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc n (ltk b s)))))
  (label 7)
  (parent 6)
  (unrealized (0 2))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton woolam-msg
  (vars (m mesg) (n n-0 text) (a s b a-0 name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a-0) (s s) (b b))
  (defstrand resp 4 (m (enc n (ltk a-0 s))) (n n-0) (a a-0) (s s) (b b))
  (precedes ((0 1) (2 2)) ((1 1) (0 4)) ((2 3) (1 0)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (added-strand resp 4)
    (enc a-0 (enc n (ltk a-0 s)) (ltk b s)) (1 0))
  (traces
    ((recv a) (send n) (recv m) (send (enc a m (ltk b s)))
      (recv (enc n (ltk b s))))
    ((recv (enc a-0 (enc n (ltk a-0 s)) (ltk b s)))
      (send (enc n (ltk b s))))
    ((recv a-0) (send n-0) (recv (enc n (ltk a-0 s)))
      (send (enc a-0 (enc n (ltk a-0 s)) (ltk b s)))))
  (label 8)
  (parent 6)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m m))))
  (origs (n-0 (2 1)) (n (0 1))))

(defskeleton woolam-msg
  (vars (n text) (a s b name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand init 3 (n n) (a a) (s s))
  (precedes ((0 1) (2 1)) ((0 3) (1 0)) ((1 1) (0 4)) ((2 2) (0 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand init 3) (enc n (ltk a s))
    (0 2))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc n (ltk b s))))
    ((recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc n (ltk b s))))
    ((send a) (recv n) (send (enc n (ltk a s)))))
  (label 9)
  (parent 7)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m (enc n (ltk a s))))))
  (origs (n (0 1))))

(defskeleton woolam-msg
  (vars (n text) (a s b a-0 name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a-0) (s s) (b a))
  (precedes ((0 1) (2 0)) ((0 3) (1 0)) ((1 1) (0 4)) ((2 1) (0 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand serv 2) (enc n (ltk a s))
    (0 2))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc n (ltk b s))))
    ((recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc n (ltk b s))))
    ((recv (enc a-0 (enc n (ltk a-0 s)) (ltk a s)))
      (send (enc n (ltk a s)))))
  (label 10)
  (parent 7)
  (unrealized (2 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton woolam-msg
  (vars (n n-0 text) (a s b a-0 name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a-0) (s s) (b a))
  (defstrand resp 4 (m (enc n (ltk a-0 s))) (n n-0) (a a-0) (s s) (b a))
  (precedes ((0 1) (3 2)) ((0 3) (1 0)) ((1 1) (0 4)) ((2 1) (0 2))
    ((3 3) (2 0)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (added-strand resp 4)
    (enc a-0 (enc n (ltk a-0 s)) (ltk a s)) (2 0))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (enc a (enc n (ltk a s)) (ltk b s)))
      (recv (enc n (ltk b s))))
    ((recv (enc a (enc n (ltk a s)) (ltk b s)))
      (send (enc n (ltk b s))))
    ((recv (enc a-0 (enc n (ltk a-0 s)) (ltk a s)))
      (send (enc n (ltk a s))))
    ((recv a-0) (send n-0) (recv (enc n (ltk a-0 s)))
      (send (enc a-0 (enc n (ltk a-0 s)) (ltk a s)))))
  (label 11)
  (parent 10)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m (enc n (ltk a s))))))
  (origs (n-0 (3 1)) (n (0 1))))

(comment "Nothing left to do")

(defprotocol woolam-msg1 basic
  (defrole init
    (vars (a s name) (n text))
    (trace (send a) (recv n) (send (enc n (ltk a s))))
    (non-orig (ltk a s)))
  (defrole resp
    (vars (a s b name) (n text) (m mesg))
    (trace (recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s))))
    (non-orig (ltk b s))
    (uniq-orig n))
  (defrole serv
    (vars (a s b name) (n text))
    (trace (recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s))))))

(defskeleton woolam-msg1
  (vars (m mesg) (n text) (a s b name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (traces
    ((recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s)))))
  (label 12)
  (unrealized (0 4))
  (origs (n (0 1)))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton woolam-msg1
  (vars (n text) (a s b name))
  (defstrand resp 5 (m (cat a n)) (n n) (a a) (s s) (b b))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (displaced 1 0 resp 4) (enc a n (ltk b s))
    (0 4))
  (traces
    ((recv a) (send n) (recv (cat a n))
      (send (cat a b (enc a n (ltk b s)))) (recv (enc a n (ltk b s)))))
  (label 13)
  (parent 12)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m (cat a n)))))
  (origs (n (0 1))))

(defskeleton woolam-msg1
  (vars (m mesg) (n n-0 text) (a s b a-0 name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand resp 4 (m (cat a n)) (n n-0) (a a-0) (s s) (b b))
  (precedes ((0 1) (1 2)) ((1 3) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (added-strand resp 4) (enc a n (ltk b s))
    (0 4))
  (traces
    ((recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv a-0) (send n-0) (recv (cat a n))
      (send (cat a-0 b (enc a n (ltk b s))))))
  (label 14)
  (parent 12)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m m))))
  (origs (n-0 (1 1)) (n (0 1))))

(defskeleton woolam-msg1
  (vars (m mesg) (n text) (a s b name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (precedes ((0 1) (1 0)) ((1 1) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand serv 2) (enc a n (ltk b s))
    (0 4))
  (traces
    ((recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s)))))
  (label 15)
  (parent 12)
  (unrealized (1 0))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton woolam-msg1
  (vars (n text) (a s b name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (precedes ((0 3) (1 0)) ((1 1) (0 4)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (displaced 2 0 resp 4)
    (enc (enc n (ltk a s)) (ltk b s)) (1 0))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s)))))
  (label 16)
  (parent 15)
  (unrealized (0 2))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton woolam-msg1
  (vars (m mesg) (n n-0 text) (a s b a-0 name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand resp 4 (m (enc n (ltk a s))) (n n-0) (a a-0) (s s) (b b))
  (precedes ((0 1) (2 2)) ((1 1) (0 4)) ((2 3) (1 0)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (added-strand resp 4)
    (enc (enc n (ltk a s)) (ltk b s)) (1 0))
  (traces
    ((recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s))))
    ((recv a-0) (send n-0) (recv (enc n (ltk a s)))
      (send (cat a-0 b (enc (enc n (ltk a s)) (ltk b s))))))
  (label 17)
  (parent 15)
  (unrealized (2 2))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton woolam-msg1
  (vars (n text) (a s b name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand init 3 (n n) (a a) (s s))
  (precedes ((0 1) (2 1)) ((0 3) (1 0)) ((1 1) (0 4)) ((2 2) (0 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n)
  (operation encryption-test (added-strand init 3) (enc n (ltk a s))
    (0 2))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s))))
    ((send a) (recv n) (send (enc n (ltk a s)))))
  (label 18)
  (parent 16)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m (enc n (ltk a s))))))
  (origs (n (0 1))))

(defskeleton woolam-msg1
  (vars (n n-0 text) (a s b a-0 name))
  (defstrand resp 5 (m (enc n (ltk a s))) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand resp 4 (m n) (n n-0) (a a-0) (s s) (b a))
  (precedes ((0 1) (2 2)) ((0 3) (1 0)) ((1 1) (0 4)) ((2 3) (0 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (added-strand resp 4) (enc n (ltk a s))
    (0 2))
  (traces
    ((recv a) (send n) (recv (enc n (ltk a s)))
      (send (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s))))
    ((recv a-0) (send n-0) (recv n)
      (send (cat a-0 a (enc n (ltk a s))))))
  (label 19)
  (parent 16)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m (enc n (ltk a s))))))
  (origs (n-0 (2 1)) (n (0 1))))

(defskeleton woolam-msg1
  (vars (m mesg) (n n-0 text) (a s b a-0 name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand resp 4 (m (enc n (ltk a s))) (n n-0) (a a-0) (s s) (b b))
  (defstrand init 3 (n n) (a a) (s s))
  (precedes ((0 1) (3 1)) ((1 1) (0 4)) ((2 3) (1 0)) ((3 2) (2 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (added-strand init 3) (enc n (ltk a s))
    (2 2))
  (traces
    ((recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s))))
    ((recv a-0) (send n-0) (recv (enc n (ltk a s)))
      (send (cat a-0 b (enc (enc n (ltk a s)) (ltk b s)))))
    ((send a) (recv n) (send (enc n (ltk a s)))))
  (label 20)
  (parent 17)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m m))))
  (origs (n-0 (2 1)) (n (0 1))))

(defskeleton woolam-msg1
  (vars (n n-0 text) (s b a name))
  (defstrand resp 5 (m n) (n n) (a b) (s s) (b b))
  (defstrand serv 2 (n n) (a b) (s s) (b b))
  (defstrand resp 4 (m (enc n (ltk b s))) (n n-0) (a a) (s s) (b b))
  (precedes ((0 3) (2 2)) ((1 1) (0 4)) ((2 3) (1 0)))
  (non-orig (ltk b s))
  (uniq-orig n n-0)
  (operation encryption-test (displaced 3 0 resp 4) (enc n (ltk a-0 s))
    (2 2))
  (traces
    ((recv b) (send n) (recv n) (send (cat b b (enc n (ltk b s))))
      (recv (enc b n (ltk b s))))
    ((recv (cat b b (enc (enc n (ltk b s)) (ltk b s))))
      (send (enc b n (ltk b s))))
    ((recv a) (send n-0) (recv (enc n (ltk b s)))
      (send (cat a b (enc (enc n (ltk b s)) (ltk b s))))))
  (label 21)
  (parent 17)
  (unrealized)
  (shape)
  (maps ((0) ((a b) (s s) (b b) (n n) (m n))))
  (origs (n (0 1)) (n-0 (2 1))))

(defskeleton woolam-msg1
  (vars (m mesg) (n n-0 n-1 text) (a s b a-0 a-1 name))
  (defstrand resp 5 (m m) (n n) (a a) (s s) (b b))
  (defstrand serv 2 (n n) (a a) (s s) (b b))
  (defstrand resp 4 (m (enc n (ltk a s))) (n n-0) (a a-0) (s s) (b b))
  (defstrand resp 4 (m n) (n n-1) (a a-1) (s s) (b a))
  (precedes ((0 1) (3 2)) ((1 1) (0 4)) ((2 3) (1 0)) ((3 3) (2 2)))
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig n n-0 n-1)
  (operation encryption-test (added-strand resp 4) (enc n (ltk a s))
    (2 2))
  (traces
    ((recv a) (send n) (recv m) (send (cat a b (enc m (ltk b s))))
      (recv (enc a n (ltk b s))))
    ((recv (cat a b (enc (enc n (ltk a s)) (ltk b s))))
      (send (enc a n (ltk b s))))
    ((recv a-0) (send n-0) (recv (enc n (ltk a s)))
      (send (cat a-0 b (enc (enc n (ltk a s)) (ltk b s)))))
    ((recv a-1) (send n-1) (recv n)
      (send (cat a-1 a (enc n (ltk a s))))))
  (label 22)
  (parent 17)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (b b) (n n) (m m))))
  (origs (n-1 (3 1)) (n-0 (2 1)) (n (0 1))))

(comment "Nothing left to do")
