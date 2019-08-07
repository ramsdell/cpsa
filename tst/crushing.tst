(comment "CPSA 4.2.0")
(comment "All input read from crushing.scm")

(defprotocol crushing basic
  (defrole init
    (vars (k akey) (n n1 n2 n3 text))
    (trace (send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n2 n3 (invk k)))
      (recv (enc n n1 n2 n3 n (invk k))))
    (non-orig (invk k))
    (uniq-orig n))
  (defrole adder
    (vars (k akey) (n new text))
    (trace (recv (enc n k)) (send (enc n new (invk k))))
    (uniq-orig new))
  (defrole twister
    (vars (k akey) (n n1 n2 n3 text))
    (trace (recv (enc n n1 n2 n3 (invk k)))
      (send (enc n n2 n3 n1 n (invk k))))))

(defskeleton crushing
  (vars (n n1 n2 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n3) (k k))
  (non-orig (invk k))
  (uniq-orig n n1 n2 n3)
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n2 n3 (invk k)))
      (recv (enc n n1 n2 n3 n (invk k)))))
  (label 0)
  (unrealized (0 1) (0 2) (0 3) (0 5))
  (origs (n (0 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 n2 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig (invk k))
  (uniq-orig n n1 n2 n3)
  (operation encryption-test (added-strand adder 2) (enc n n1 (invk k))
    (0 1))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n2 n3 (invk k)))
      (recv (enc n n1 n2 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k)))))
  (label 1)
  (parent 0)
  (unrealized (0 2) (0 3) (0 5))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton crushing
  (vars (n n1 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n1) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig (invk k))
  (uniq-orig n n1 n3)
  (operation encryption-test (displaced 2 1 adder 2) (enc n n2 (invk k))
    (0 2))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n1 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n1 n3 (invk k)))
      (recv (enc n n1 n1 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k)))))
  (label 2)
  (parent 1)
  (unrealized (0 3) (0 5))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton crushing
  (vars (n n1 n2 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (0 2)))
  (non-orig (invk k))
  (uniq-orig n n1 n2 n3)
  (operation encryption-test (added-strand adder 2) (enc n n2 (invk k))
    (0 2))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n2 n3 (invk k)))
      (recv (enc n n1 n2 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k)))))
  (label 3)
  (parent 1)
  (unrealized (0 3) (0 5))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton crushing
  (vars (n n1 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n1) (n3 n1) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig (invk k))
  (uniq-orig n n1)
  (operation encryption-test (displaced 2 1 adder 2) (enc n n3 (invk k))
    (0 3))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n1 (invk k))) (recv (enc n n1 (invk k)))
      (send (enc n n1 n1 n1 (invk k)))
      (recv (enc n n1 n1 n1 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k)))))
  (label 4)
  (parent 2)
  (unrealized (0 5))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n1) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n3) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (0 3)))
  (non-orig (invk k))
  (uniq-orig n n1 n3)
  (operation encryption-test (added-strand adder 2) (enc n n3 (invk k))
    (0 3))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n1 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n1 n3 (invk k)))
      (recv (enc n n1 n1 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n3 (invk k)))))
  (label 5)
  (parent 2)
  (unrealized (0 5))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 n2 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n1) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (0 2)))
  (non-orig (invk k))
  (uniq-orig n n1 n2)
  (operation encryption-test (displaced 3 1 adder 2) (enc n n3 (invk k))
    (0 3))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n1 (invk k)))
      (send (enc n n1 n2 n1 (invk k)))
      (recv (enc n n1 n2 n1 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k)))))
  (label 6)
  (parent 3)
  (unrealized (0 5))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 n2 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n2) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (0 2)))
  (non-orig (invk k))
  (uniq-orig n n1 n2)
  (operation encryption-test (displaced 3 2 adder 2) (enc n n3 (invk k))
    (0 3))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n2 (invk k)))
      (send (enc n n1 n2 n2 (invk k)))
      (recv (enc n n1 n2 n2 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k)))))
  (label 7)
  (parent 3)
  (unrealized (0 5))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 n2 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (defstrand adder 2 (n n) (new n3) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((0 0) (3 0)) ((1 1) (0 1))
    ((2 1) (0 2)) ((3 1) (0 3)))
  (non-orig (invk k))
  (uniq-orig n n1 n2 n3)
  (operation encryption-test (added-strand adder 2) (enc n n3 (invk k))
    (0 3))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n2 n3 (invk k)))
      (recv (enc n n1 n2 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k))))
    ((recv (enc n k)) (send (enc n n3 (invk k)))))
  (label 8)
  (parent 3)
  (unrealized (0 5))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n1) (n3 n1) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand twister 2 (n n) (n1 n1) (n2 n1) (n3 n1) (k k))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)) ((1 1) (2 0)) ((2 1) (0 5)))
  (non-orig (invk k))
  (uniq-orig n n1)
  (operation encryption-test (added-strand twister 2)
    (enc n n1 n1 n1 n (invk k)) (0 5))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n1 (invk k))) (recv (enc n n1 (invk k)))
      (send (enc n n1 n1 n1 (invk k)))
      (recv (enc n n1 n1 n1 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n n1 n1 n1 (invk k)))
      (send (enc n n1 n1 n1 n (invk k)))))
  (label 9)
  (parent 4)
  (unrealized (2 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton crushing
  (vars (n n1 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n1) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n3) (k k))
  (defstrand twister 2 (n n) (n1 n3) (n2 n1) (n3 n1) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((1 1) (3 0))
    ((2 1) (0 3)) ((2 1) (3 0)) ((3 1) (0 5)))
  (non-orig (invk k))
  (uniq-orig n n1 n3)
  (operation encryption-test (added-strand twister 2)
    (enc n n1 n1 n3 n (invk k)) (0 5))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n1 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n1 n3 (invk k)))
      (recv (enc n n1 n1 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n3 (invk k))))
    ((recv (enc n n3 n1 n1 (invk k)))
      (send (enc n n1 n1 n3 n (invk k)))))
  (label 10)
  (parent 5)
  (unrealized (3 0))
  (dead)
  (comment "empty cohort"))

(defskeleton crushing
  (vars (n n1 n2 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n1) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (defstrand twister 2 (n n) (n1 n1) (n2 n1) (n3 n2) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((1 1) (3 0))
    ((2 1) (0 2)) ((2 1) (3 0)) ((3 1) (0 5)))
  (non-orig (invk k))
  (uniq-orig n n1 n2)
  (operation encryption-test (added-strand twister 2)
    (enc n n1 n2 n1 n (invk k)) (0 5))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n1 (invk k)))
      (send (enc n n1 n2 n1 (invk k)))
      (recv (enc n n1 n2 n1 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k))))
    ((recv (enc n n1 n1 n2 (invk k)))
      (send (enc n n1 n2 n1 n (invk k)))))
  (label 11)
  (parent 6)
  (unrealized (3 0))
  (dead)
  (comment "empty cohort"))

(defskeleton crushing
  (vars (n n1 n2 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n2) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (defstrand twister 2 (n n) (n1 n2) (n2 n1) (n3 n2) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((1 1) (0 1)) ((1 1) (3 0))
    ((2 1) (0 2)) ((2 1) (3 0)) ((3 1) (0 5)))
  (non-orig (invk k))
  (uniq-orig n n1 n2)
  (operation encryption-test (added-strand twister 2)
    (enc n n1 n2 n2 n (invk k)) (0 5))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n2 (invk k)))
      (send (enc n n1 n2 n2 (invk k)))
      (recv (enc n n1 n2 n2 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k))))
    ((recv (enc n n2 n1 n2 (invk k)))
      (send (enc n n1 n2 n2 n (invk k)))))
  (label 12)
  (parent 7)
  (unrealized (3 0))
  (dead)
  (comment "empty cohort"))

(defskeleton crushing
  (vars (n n1 n2 n3 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n2) (n3 n3) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand adder 2 (n n) (new n2) (k k))
  (defstrand adder 2 (n n) (new n3) (k k))
  (defstrand twister 2 (n n) (n1 n3) (n2 n1) (n3 n2) (k k))
  (precedes ((0 0) (1 0)) ((0 0) (2 0)) ((0 0) (3 0)) ((1 1) (0 1))
    ((1 1) (4 0)) ((2 1) (0 2)) ((2 1) (4 0)) ((3 1) (0 3))
    ((3 1) (4 0)) ((4 1) (0 5)))
  (non-orig (invk k))
  (uniq-orig n n1 n2 n3)
  (operation encryption-test (added-strand twister 2)
    (enc n n1 n2 n3 n (invk k)) (0 5))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n2 (invk k))) (recv (enc n n3 (invk k)))
      (send (enc n n1 n2 n3 (invk k)))
      (recv (enc n n1 n2 n3 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n k)) (send (enc n n2 (invk k))))
    ((recv (enc n k)) (send (enc n n3 (invk k))))
    ((recv (enc n n3 n1 n2 (invk k)))
      (send (enc n n1 n2 n3 n (invk k)))))
  (label 13)
  (parent 8)
  (unrealized (4 0))
  (dead)
  (comment "empty cohort"))

(defskeleton crushing
  (vars (n n1 text) (k akey))
  (defstrand init 6 (n n) (n1 n1) (n2 n1) (n3 n1) (k k))
  (defstrand adder 2 (n n) (new n1) (k k))
  (defstrand twister 2 (n n) (n1 n1) (n2 n1) (n3 n1) (k k))
  (precedes ((0 0) (1 0)) ((0 4) (2 0)) ((1 1) (0 1)) ((2 1) (0 5)))
  (non-orig (invk k))
  (uniq-orig n n1)
  (operation encryption-test (displaced 3 0 init 5)
    (enc n n1 n1 n1 (invk k)) (2 0))
  (traces
    ((send (enc n k)) (recv (enc n n1 (invk k)))
      (recv (enc n n1 (invk k))) (recv (enc n n1 (invk k)))
      (send (enc n n1 n1 n1 (invk k)))
      (recv (enc n n1 n1 n1 n (invk k))))
    ((recv (enc n k)) (send (enc n n1 (invk k))))
    ((recv (enc n n1 n1 n1 (invk k)))
      (send (enc n n1 n1 n1 n (invk k)))))
  (label 14)
  (parent 9)
  (unrealized)
  (shape)
  (maps ((0) ((k k) (n n) (n1 n1) (n2 n1) (n3 n1))))
  (origs (n (0 0)) (n1 (1 1))))

(comment "Nothing left to do")
