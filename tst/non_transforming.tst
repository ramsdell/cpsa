(comment "CPSA 4.2.0")
(comment "All input read from non_transforming.scm")

(defprotocol non_transforming basic
  (defrole sender
    (vars (a b text) (B name))
    (trace (send (enc a b (pubk B))))
    (non-orig (privk B))
    (uniq-orig a b))
  (defrole recv
    (vars (a b text) (B name))
    (trace (recv (enc a (pubk B))) (recv (enc b (pubk B)))))
  (defrole breaker
    (vars (a b text) (B name))
    (trace (recv (enc a b (pubk B))) (send (enc a (pubk B)))
      (send (enc b (pubk B))))))

(defskeleton non_transforming
  (vars (a b c d text) (B B0 B1 name))
  (defstrand recv 2 (a a) (b b) (B B))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand sender 1 (a c) (b b) (B B1))
  (precedes ((1 0) (0 0)) ((2 0) (0 1)))
  (non-orig (privk B0) (privk B1))
  (uniq-orig a b c d)
  (traces ((recv (enc a (pubk B))) (recv (enc b (pubk B))))
    ((send (enc a d (pubk B0)))) ((send (enc c b (pubk B1)))))
  (label 0)
  (unrealized (0 0) (0 1))
  (origs (c (2 0)) (d (1 0)) (a (1 0)) (b (2 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton non_transforming
  (vars (a d text) (B B0 name))
  (defstrand recv 2 (a a) (b d) (B B))
  (defstrand sender 1 (a a) (b d) (B B0))
  (precedes ((1 0) (0 0)))
  (non-orig (privk B0))
  (uniq-orig a d)
  (operation collapsed 2 1)
  (traces ((recv (enc a (pubk B))) (recv (enc d (pubk B))))
    ((send (enc a d (pubk B0)))))
  (label 1)
  (parent 0)
  (unrealized (0 0) (0 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton non_transforming
  (vars (a b c d text) (B B0 B1 name))
  (defstrand recv 2 (a a) (b b) (B B))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand sender 1 (a c) (b b) (B B1))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (precedes ((1 0) (3 0)) ((2 0) (0 1)) ((3 1) (0 0)))
  (non-orig (privk B0) (privk B1))
  (uniq-orig a b c d)
  (operation nonce-test (added-strand breaker 2) a (0 0)
    (enc a d (pubk B0)))
  (traces ((recv (enc a (pubk B))) (recv (enc b (pubk B))))
    ((send (enc a d (pubk B0)))) ((send (enc c b (pubk B1))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0)))))
  (label 2)
  (parent 0)
  (unrealized (0 0) (0 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton non_transforming
  (vars (a d text) (B B0 name))
  (defstrand recv 2 (a a) (b d) (B B))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (precedes ((1 0) (2 0)) ((2 1) (0 0)))
  (non-orig (privk B0))
  (uniq-orig a d)
  (operation nonce-test (added-strand breaker 2) a (0 0)
    (enc a d (pubk B0)))
  (traces ((recv (enc a (pubk B))) (recv (enc d (pubk B))))
    ((send (enc a d (pubk B0))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0)))))
  (label 3)
  (parent 1)
  (unrealized (0 0) (0 1))
  (origs (a (1 0)) (d (1 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton non_transforming
  (vars (a b c d text) (B0 B1 name))
  (defstrand recv 2 (a a) (b b) (B B0))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand sender 1 (a c) (b b) (B B1))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (precedes ((1 0) (3 0)) ((2 0) (0 1)) ((3 1) (0 0)))
  (non-orig (privk B0) (privk B1))
  (uniq-orig a b c d)
  (operation nonce-test (contracted (B B0)) a (0 0) (enc a (pubk B0))
    (enc a d (pubk B0)))
  (traces ((recv (enc a (pubk B0))) (recv (enc b (pubk B0))))
    ((send (enc a d (pubk B0)))) ((send (enc c b (pubk B1))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0)))))
  (label 4)
  (parent 2)
  (unrealized (0 1))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton non_transforming
  (vars (a d text) (B0 name))
  (defstrand recv 2 (a a) (b d) (B B0))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (precedes ((1 0) (2 0)) ((2 1) (0 0)))
  (non-orig (privk B0))
  (uniq-orig a d)
  (operation nonce-test (contracted (B B0)) a (0 0) (enc a (pubk B0))
    (enc a d (pubk B0)))
  (traces ((recv (enc a (pubk B0))) (recv (enc d (pubk B0))))
    ((send (enc a d (pubk B0))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0)))))
  (label 5)
  (parent 3)
  (unrealized (0 1))
  (origs (a (1 0)) (d (1 0)))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton non_transforming
  (vars (a b c d text) (B0 B1 name))
  (defstrand recv 2 (a a) (b b) (B B0))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand sender 1 (a c) (b b) (B B1))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (defstrand breaker 3 (a c) (b b) (B B1))
  (precedes ((1 0) (3 0)) ((2 0) (4 0)) ((3 1) (0 0)) ((4 2) (0 1)))
  (non-orig (privk B0) (privk B1))
  (uniq-orig a b c d)
  (operation nonce-test (added-strand breaker 3) b (0 1)
    (enc c b (pubk B1)))
  (traces ((recv (enc a (pubk B0))) (recv (enc b (pubk B0))))
    ((send (enc a d (pubk B0)))) ((send (enc c b (pubk B1))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0))))
    ((recv (enc c b (pubk B1))) (send (enc c (pubk B1)))
      (send (enc b (pubk B1)))))
  (label 6)
  (parent 4)
  (unrealized (0 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton non_transforming
  (vars (a c d text) (B0 B1 name))
  (defstrand recv 2 (a a) (b c) (B B0))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand sender 1 (a c) (b c) (B B1))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (defstrand breaker 2 (a c) (b c) (B B1))
  (precedes ((1 0) (3 0)) ((2 0) (4 0)) ((3 1) (0 0)) ((4 1) (0 1)))
  (non-orig (privk B0) (privk B1))
  (uniq-orig a c d)
  (operation nonce-test (added-strand breaker 2) c (0 1)
    (enc c c (pubk B1)))
  (traces ((recv (enc a (pubk B0))) (recv (enc c (pubk B0))))
    ((send (enc a d (pubk B0)))) ((send (enc c c (pubk B1))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0))))
    ((recv (enc c c (pubk B1))) (send (enc c (pubk B1)))))
  (label 7)
  (parent 4)
  (unrealized (0 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton non_transforming
  (vars (a d text) (B0 name))
  (defstrand recv 2 (a a) (b d) (B B0))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand breaker 3 (a a) (b d) (B B0))
  (precedes ((1 0) (2 0)) ((2 1) (0 0)) ((2 2) (0 1)))
  (non-orig (privk B0))
  (uniq-orig a d)
  (operation nonce-test (displaced 2 3 breaker 3) d (0 1)
    (enc a d (pubk B0)))
  (traces ((recv (enc a (pubk B0))) (recv (enc d (pubk B0))))
    ((send (enc a d (pubk B0))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0)))
      (send (enc d (pubk B0)))))
  (label 8)
  (parent 5)
  (unrealized)
  (shape)
  (maps ((0 1 1) ((a a) (b d) (c a) (d d) (B B0) (B0 B0) (B1 B0))))
  (origs (a (1 0)) (d (1 0))))

(defskeleton non_transforming
  (vars (a d text) (B0 name))
  (defstrand recv 2 (a a) (b d) (B B0))
  (defstrand sender 1 (a a) (b d) (B B0))
  (defstrand breaker 2 (a a) (b d) (B B0))
  (defstrand breaker 3 (a a) (b d) (B B0))
  (precedes ((1 0) (2 0)) ((1 0) (3 0)) ((2 1) (0 0)) ((3 2) (0 1)))
  (non-orig (privk B0))
  (uniq-orig a d)
  (operation nonce-test (added-strand breaker 3) d (0 1)
    (enc a d (pubk B0)))
  (traces ((recv (enc a (pubk B0))) (recv (enc d (pubk B0))))
    ((send (enc a d (pubk B0))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0))))
    ((recv (enc a d (pubk B0))) (send (enc a (pubk B0)))
      (send (enc d (pubk B0)))))
  (label 9)
  (parent 5)
  (unrealized)
  (shape)
  (maps ((0 1 1) ((a a) (b d) (c a) (d d) (B B0) (B0 B0) (B1 B0))))
  (origs (a (1 0)) (d (1 0))))

(defskeleton non_transforming
  (vars (a text) (B0 name))
  (defstrand recv 2 (a a) (b a) (B B0))
  (defstrand sender 1 (a a) (b a) (B B0))
  (defstrand breaker 2 (a a) (b a) (B B0))
  (precedes ((1 0) (2 0)) ((2 1) (0 0)))
  (non-orig (privk B0))
  (uniq-orig a)
  (operation nonce-test (displaced 3 2 breaker 2) a (0 1)
    (enc a a (pubk B0)))
  (traces ((recv (enc a (pubk B0))) (recv (enc a (pubk B0))))
    ((send (enc a a (pubk B0))))
    ((recv (enc a a (pubk B0))) (send (enc a (pubk B0)))))
  (label 10)
  (parent 5)
  (unrealized)
  (shape)
  (maps ((0 1 1) ((a a) (b a) (c a) (d a) (B B0) (B0 B0) (B1 B0))))
  (origs (a (1 0))))

(defskeleton non_transforming
  (vars (a b c d text) (B1 name))
  (defstrand recv 2 (a a) (b b) (B B1))
  (defstrand sender 1 (a a) (b d) (B B1))
  (defstrand sender 1 (a c) (b b) (B B1))
  (defstrand breaker 2 (a a) (b d) (B B1))
  (defstrand breaker 3 (a c) (b b) (B B1))
  (precedes ((1 0) (3 0)) ((2 0) (4 0)) ((3 1) (0 0)) ((4 2) (0 1)))
  (non-orig (privk B1))
  (uniq-orig a b c d)
  (operation nonce-test (contracted (B0 B1)) b (0 1) (enc b (pubk B1))
    (enc c b (pubk B1)))
  (traces ((recv (enc a (pubk B1))) (recv (enc b (pubk B1))))
    ((send (enc a d (pubk B1)))) ((send (enc c b (pubk B1))))
    ((recv (enc a d (pubk B1))) (send (enc a (pubk B1))))
    ((recv (enc c b (pubk B1))) (send (enc c (pubk B1)))
      (send (enc b (pubk B1)))))
  (label 11)
  (parent 6)
  (unrealized)
  (shape)
  (maps ((0 1 2) ((a a) (b b) (c c) (d d) (B B1) (B0 B1) (B1 B1))))
  (origs (c (2 0)) (d (1 0)) (a (1 0)) (b (2 0))))

(defskeleton non_transforming
  (vars (a c d text) (B1 name))
  (defstrand recv 2 (a a) (b c) (B B1))
  (defstrand sender 1 (a a) (b d) (B B1))
  (defstrand sender 1 (a c) (b c) (B B1))
  (defstrand breaker 2 (a a) (b d) (B B1))
  (defstrand breaker 2 (a c) (b c) (B B1))
  (precedes ((1 0) (3 0)) ((2 0) (4 0)) ((3 1) (0 0)) ((4 1) (0 1)))
  (non-orig (privk B1))
  (uniq-orig a c d)
  (operation nonce-test (contracted (B0 B1)) c (0 1) (enc c (pubk B1))
    (enc c c (pubk B1)))
  (traces ((recv (enc a (pubk B1))) (recv (enc c (pubk B1))))
    ((send (enc a d (pubk B1)))) ((send (enc c c (pubk B1))))
    ((recv (enc a d (pubk B1))) (send (enc a (pubk B1))))
    ((recv (enc c c (pubk B1))) (send (enc c (pubk B1)))))
  (label 12)
  (parent 7)
  (unrealized)
  (shape)
  (maps ((0 1 2) ((a a) (b c) (c c) (d d) (B B1) (B0 B1) (B1 B1))))
  (origs (c (2 0)) (d (1 0)) (a (1 0))))

(comment "Nothing left to do")
