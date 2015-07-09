(comment "CPSA 2.5.2")
(comment "All input read from mass2.lsp")

(defprotocol mass2 basic
  (defrole init
    (vars (a b name) (n1 n2 text))
    (trace (send (cat a n2)) (recv (cat n1 (enc n2 (ltk a b))))
      (send (enc n1 (ltk a b)))))
  (defrole resp
    (vars (a b name) (n1 n2 text))
    (trace (recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))))

(defskeleton mass2
  (vars (n1 n2 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b)))))
  (label 0)
  (unrealized (0 2))
  (origs (n1 (0 1)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 n2-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n1 (ltk a b))
    (0 2))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b)))))
  (label 1)
  (parent 0)
  (unrealized (1 1))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n1) (a a) (b b))
  (precedes ((0 1) (1 0)) ((1 1) (0 2)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n1 (ltk a b))
    (0 2))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((recv (cat a n1)) (send (cat n1-0 (enc n1 (ltk a b))))))
  (label 2)
  (parent 0)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n2-0 (ltk a b))
    (1 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b)))))
  (label 3)
  (parent 1)
  (unrealized (2 1))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (displaced 2 0 resp 2) (enc n2-0 (ltk a b))
    (1 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2)) (recv (cat n1 (enc n2 (ltk a b))))
      (send (enc n1 (ltk a b)))))
  (label 4)
  (parent 1)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n2-0) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 1) (1 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n2-0 (ltk a b))
    (1 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((recv (cat a n2-0)) (send (cat n1-0 (enc n2-0 (ltk a b))))))
  (label 5)
  (parent 1)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n2-1 (ltk a b))
    (2 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b)))))
  (label 6)
  (parent 3)
  (unrealized (3 1))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 n2-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2) (a a) (b b))
  (precedes ((0 1) (2 1)) ((1 2) (0 2)) ((2 2) (1 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (displaced 3 0 resp 2) (enc n2-1 (ltk a b))
    (2 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2)) (recv (cat n2-0 (enc n2 (ltk a b))))
      (send (enc n2-0 (ltk a b)))))
  (label 7)
  (parent 3)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n2-1) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 1) (2 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n2-1 (ltk a b))
    (2 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((recv (cat a n2-1)) (send (cat n1-0 (enc n2-1 (ltk a b))))))
  (label 8)
  (parent 3)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n2-2 (ltk a b))
    (3 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b)))))
  (label 9)
  (parent 6)
  (unrealized (4 1))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2) (a a) (b b))
  (precedes ((0 1) (3 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (displaced 4 0 resp 2) (enc n2-2 (ltk a b))
    (3 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2)) (recv (cat n2-1 (enc n2 (ltk a b))))
      (send (enc n2-1 (ltk a b)))))
  (label 10)
  (parent 6)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n2-2) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 1) (3 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n2-2 (ltk a b))
    (3 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((recv (cat a n2-2)) (send (cat n1-0 (enc n2-2 (ltk a b))))))
  (label 11)
  (parent 6)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n2-4 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2-4) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n2-3 (ltk a b))
    (4 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2-4)) (recv (cat n2-3 (enc n2-4 (ltk a b))))
      (send (enc n2-3 (ltk a b)))))
  (label 12)
  (parent 9)
  (unrealized (5 1))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2) (a a) (b b))
  (precedes ((0 1) (4 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (displaced 5 0 resp 2) (enc n2-3 (ltk a b))
    (4 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2)) (recv (cat n2-2 (enc n2 (ltk a b))))
      (send (enc n2-2 (ltk a b)))))
  (label 13)
  (parent 9)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n2-3) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 1) (4 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n2-3 (ltk a b))
    (4 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((recv (cat a n2-3)) (send (cat n1-0 (enc n2-3 (ltk a b))))))
  (label 14)
  (parent 9)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n2-4 n2-5 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2-4) (a a) (b b))
  (defstrand init 3 (n1 n2-4) (n2 n2-5) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)) ((6 2) (5 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n2-4 (ltk a b))
    (5 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2-4)) (recv (cat n2-3 (enc n2-4 (ltk a b))))
      (send (enc n2-3 (ltk a b))))
    ((send (cat a n2-5)) (recv (cat n2-4 (enc n2-5 (ltk a b))))
      (send (enc n2-4 (ltk a b)))))
  (label 15)
  (parent 12)
  (unrealized (6 1))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2) (a a) (b b))
  (precedes ((0 1) (5 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (displaced 6 0 resp 2) (enc n2-4 (ltk a b))
    (5 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2)) (recv (cat n2-3 (enc n2 (ltk a b))))
      (send (enc n2-3 (ltk a b)))))
  (label 16)
  (parent 12)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n2-4 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2-4) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n2-4) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)) ((6 1) (5 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n2-4 (ltk a b))
    (5 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2-4)) (recv (cat n2-3 (enc n2-4 (ltk a b))))
      (send (enc n2-3 (ltk a b))))
    ((recv (cat a n2-4)) (send (cat n1-0 (enc n2-4 (ltk a b))))))
  (label 17)
  (parent 12)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n2-4 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2-4) (a a) (b b))
  (defstrand init 3 (n1 n2-4) (n2 n2) (a a) (b b))
  (precedes ((0 1) (6 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)) ((6 2) (5 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (displaced 7 0 resp 2) (enc n2-5 (ltk a b))
    (6 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2-4)) (recv (cat n2-3 (enc n2-4 (ltk a b))))
      (send (enc n2-3 (ltk a b))))
    ((send (cat a n2)) (recv (cat n2-4 (enc n2 (ltk a b))))
      (send (enc n2-4 (ltk a b)))))
  (label 19)
  (parent 15)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (n1 n1) (n2 n2))))
  (origs (n1 (0 1))))

(comment "Strand bound exceeded--aborting run")

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n2-4 n2-5 n2-6 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2-4) (a a) (b b))
  (defstrand init 3 (n1 n2-4) (n2 n2-5) (a a) (b b))
  (defstrand init 3 (n1 n2-5) (n2 n2-6) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)) ((6 2) (5 1)) ((7 2) (6 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand init 3) (enc n2-5 (ltk a b))
    (6 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2-4)) (recv (cat n2-3 (enc n2-4 (ltk a b))))
      (send (enc n2-3 (ltk a b))))
    ((send (cat a n2-5)) (recv (cat n2-4 (enc n2-5 (ltk a b))))
      (send (enc n2-4 (ltk a b))))
    ((send (cat a n2-6)) (recv (cat n2-5 (enc n2-6 (ltk a b))))
      (send (enc n2-5 (ltk a b)))))
  (label 18)
  (parent 15)
  (unrealized (7 1))
  (comment "aborted"))

(defskeleton mass2
  (vars (n1 n2 n2-0 n2-1 n2-2 n2-3 n2-4 n2-5 n1-0 text) (a b name))
  (defstrand resp 3 (n1 n1) (n2 n2) (a a) (b b))
  (defstrand init 3 (n1 n1) (n2 n2-0) (a a) (b b))
  (defstrand init 3 (n1 n2-0) (n2 n2-1) (a a) (b b))
  (defstrand init 3 (n1 n2-1) (n2 n2-2) (a a) (b b))
  (defstrand init 3 (n1 n2-2) (n2 n2-3) (a a) (b b))
  (defstrand init 3 (n1 n2-3) (n2 n2-4) (a a) (b b))
  (defstrand init 3 (n1 n2-4) (n2 n2-5) (a a) (b b))
  (defstrand resp 2 (n1 n1-0) (n2 n2-5) (a a) (b b))
  (precedes ((0 1) (1 1)) ((1 2) (0 2)) ((2 2) (1 1)) ((3 2) (2 1))
    ((4 2) (3 1)) ((5 2) (4 1)) ((6 2) (5 1)) ((7 1) (6 1)))
  (non-orig (ltk a b))
  (uniq-orig n1)
  (operation encryption-test (added-strand resp 2) (enc n2-5 (ltk a b))
    (6 1))
  (traces
    ((recv (cat a n2)) (send (cat n1 (enc n2 (ltk a b))))
      (recv (enc n1 (ltk a b))))
    ((send (cat a n2-0)) (recv (cat n1 (enc n2-0 (ltk a b))))
      (send (enc n1 (ltk a b))))
    ((send (cat a n2-1)) (recv (cat n2-0 (enc n2-1 (ltk a b))))
      (send (enc n2-0 (ltk a b))))
    ((send (cat a n2-2)) (recv (cat n2-1 (enc n2-2 (ltk a b))))
      (send (enc n2-1 (ltk a b))))
    ((send (cat a n2-3)) (recv (cat n2-2 (enc n2-3 (ltk a b))))
      (send (enc n2-2 (ltk a b))))
    ((send (cat a n2-4)) (recv (cat n2-3 (enc n2-4 (ltk a b))))
      (send (enc n2-3 (ltk a b))))
    ((send (cat a n2-5)) (recv (cat n2-4 (enc n2-5 (ltk a b))))
      (send (enc n2-4 (ltk a b))))
    ((recv (cat a n2-5)) (send (cat n1-0 (enc n2-5 (ltk a b))))))
  (label 20)
  (parent 15)
  (unrealized)
  (comment "aborted"))
