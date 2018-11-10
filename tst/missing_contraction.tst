(comment "CPSA 4.1.2")
(comment "All input read from missing_contraction.scm")

(defprotocol missing-contraction basic
  (defrole sender
    (vars (m n text) (a b name))
    (trace (send (enc a m (pubk a))) (send (enc a n (pubk b)))))
  (defrole receiver
    (vars (m text) (a b name))
    (trace (recv (enc a m (pubk b))))))

(defskeleton missing-contraction
  (vars (m n text) (a c b name))
  (defstrand sender 2 (m m) (n n) (a a) (b b))
  (defstrand receiver 1 (m m) (a a) (b c))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a))
  (uniq-orig m)
  (traces ((send (enc a m (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a m (pubk c)))))
  (label 0)
  (unrealized (1 0))
  (origs (m (0 0)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton missing-contraction
  (vars (m n text) (a b name))
  (defstrand sender 2 (m m) (n n) (a a) (b b))
  (defstrand receiver 1 (m m) (a a) (b a))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a))
  (uniq-orig m)
  (operation nonce-test (contracted (c a)) m (1 0) (enc a m (pubk a)))
  (traces ((send (enc a m (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a m (pubk a)))))
  (label 1)
  (parent 0)
  (unrealized)
  (shape)
  (maps ((0 1) ((m m) (a a) (c a) (n n) (b b))))
  (origs (m (0 0))))

(defskeleton missing-contraction
  (vars (n text) (a c b name))
  (defstrand sender 2 (m n) (n n) (a a) (b b))
  (defstrand receiver 1 (m n) (a a) (b c))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a))
  (uniq-orig n)
  (operation nonce-test (displaced 2 0 sender 2) m (1 0)
    (enc a m (pubk a)))
  (traces ((send (enc a n (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a n (pubk c)))))
  (label 2)
  (parent 0)
  (unrealized)
  (shape)
  (maps ((0 1) ((m n) (a a) (c c) (n n) (b b))))
  (origs (n (0 0))))

(comment "Nothing left to do")

(defprotocol missing-contraction basic
  (defrole sender
    (vars (m n text) (a b name))
    (trace (send (enc a m (pubk a))) (send (enc a n (pubk b)))))
  (defrole receiver
    (vars (m text) (a b name))
    (trace (recv (enc a m (pubk b))))))

(defskeleton missing-contraction
  (vars (m text) (a c name))
  (defstrand sender 1 (m m) (a a))
  (deflistener (enc a m (pubk c)))
  (non-orig (privk a))
  (uniq-orig m)
  (traces ((send (enc a m (pubk a))))
    ((recv (enc a m (pubk c))) (send (enc a m (pubk c)))))
  (label 3)
  (unrealized (1 0))
  (origs (m (0 0)))
  (preskeleton)
  (comment "Not a skeleton"))

(defskeleton missing-contraction
  (vars (m text) (a c name))
  (defstrand sender 1 (m m) (a a))
  (deflistener (enc a m (pubk c)))
  (precedes ((0 0) (1 0)))
  (non-orig (privk a))
  (uniq-orig m)
  (traces ((send (enc a m (pubk a))))
    ((recv (enc a m (pubk c))) (send (enc a m (pubk c)))))
  (label 4)
  (parent 3)
  (unrealized (1 0))
  (origs (m (0 0)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton missing-contraction
  (vars (m text) (a name))
  (defstrand sender 1 (m m) (a a))
  (deflistener (enc a m (pubk a)))
  (precedes ((0 0) (1 0)))
  (non-orig (privk a))
  (uniq-orig m)
  (operation nonce-test (contracted (c a)) m (1 0) (enc a m (pubk a)))
  (traces ((send (enc a m (pubk a))))
    ((recv (enc a m (pubk a))) (send (enc a m (pubk a)))))
  (label 5)
  (parent 4)
  (unrealized)
  (shape)
  (maps ((0 1) ((m m) (a a) (c a))))
  (origs (m (0 0))))

(defskeleton missing-contraction
  (vars (m text) (c a b name))
  (deflistener (enc a m (pubk c)))
  (defstrand sender 2 (m m) (n m) (a a) (b b))
  (precedes ((1 1) (0 0)))
  (non-orig (privk a))
  (uniq-orig m)
  (operation nonce-test (displaced 0 2 sender 2) m-0 (1 0)
    (enc a-0 m-0 (pubk a-0)))
  (traces ((recv (enc a m (pubk c))) (send (enc a m (pubk c))))
    ((send (enc a m (pubk a))) (send (enc a m (pubk b)))))
  (label 6)
  (parent 4)
  (unrealized)
  (shape)
  (maps ((1 0) ((m m) (a a) (c c))))
  (origs (m (1 0))))

(comment "Nothing left to do")

(defprotocol missing-contraction basic
  (defrole sender
    (vars (m n text) (a b name))
    (trace (send (enc a m (pubk a))) (send (enc a n (pubk b)))))
  (defrole receiver
    (vars (m text) (a b name))
    (trace (recv (enc a m (pubk b))))))

(defskeleton missing-contraction
  (vars (m n text) (a b c name))
  (defstrand sender 2 (m m) (n n) (a a) (b b))
  (defstrand receiver 1 (m m) (a a) (b c))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a) (privk b))
  (uniq-orig m)
  (traces ((send (enc a m (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a m (pubk c)))))
  (label 7)
  (unrealized (1 0))
  (origs (m (0 0)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton missing-contraction
  (vars (m n text) (a b name))
  (defstrand sender 2 (m m) (n n) (a a) (b b))
  (defstrand receiver 1 (m m) (a a) (b a))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a) (privk b))
  (uniq-orig m)
  (operation nonce-test (contracted (c a)) m (1 0) (enc a m (pubk a)))
  (traces ((send (enc a m (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a m (pubk a)))))
  (label 8)
  (parent 7)
  (unrealized)
  (shape)
  (maps ((0 1) ((m m) (a a) (b b) (c a) (n n))))
  (origs (m (0 0))))

(defskeleton missing-contraction
  (vars (n text) (a b c name))
  (defstrand sender 2 (m n) (n n) (a a) (b b))
  (defstrand receiver 1 (m n) (a a) (b c))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a) (privk b))
  (uniq-orig n)
  (operation nonce-test (displaced 2 0 sender 2) m (1 0)
    (enc a m (pubk a)))
  (traces ((send (enc a n (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a n (pubk c)))))
  (label 9)
  (parent 7)
  (unrealized (1 0))
  (origs (n (0 0)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton missing-contraction
  (vars (n text) (a b name))
  (defstrand sender 2 (m n) (n n) (a a) (b b))
  (defstrand receiver 1 (m n) (a a) (b a))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a) (privk b))
  (uniq-orig n)
  (operation nonce-test (contracted (c a)) n (1 0) (enc a n (pubk a))
    (enc a n (pubk b)))
  (traces ((send (enc a n (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a n (pubk a)))))
  (label 10)
  (parent 9)
  (seen 8)
  (unrealized)
  (origs (n (0 0)))
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton missing-contraction
  (vars (n text) (a b name))
  (defstrand sender 2 (m n) (n n) (a a) (b b))
  (defstrand receiver 1 (m n) (a a) (b b))
  (precedes ((0 1) (1 0)))
  (non-orig (privk a) (privk b))
  (uniq-orig n)
  (operation nonce-test (contracted (c b)) n (1 0) (enc a n (pubk a))
    (enc a n (pubk b)))
  (traces ((send (enc a n (pubk a))) (send (enc a n (pubk b))))
    ((recv (enc a n (pubk b)))))
  (label 11)
  (parent 9)
  (unrealized)
  (shape)
  (maps ((0 1) ((m n) (a a) (b b) (c b) (n n))))
  (origs (n (0 0))))

(comment "Nothing left to do")
