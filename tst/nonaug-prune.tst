(comment "CPSA 4.2.0")
(comment "All input read from nonaug-prune.scm")

(defprotocol nonaug-prune basic
  (defrole orig
    (vars (n text) (A B name) (k akey))
    (trace (send (enc n B B k)) (send (enc n A k))
      (recv (enc n A A A k)))
    (non-orig (invk k))
    (uniq-orig n))
  (defrole trans1
    (vars (n text) (A C name) (k akey))
    (trace (recv (enc n A A k)) (recv (enc n A k))
      (send (enc n n C k))))
  (defrole trans2
    (vars (n text) (A name) (k akey))
    (trace (recv (enc n A k)) (send (enc n A A A k)))))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k))))
  (label 0)
  (unrealized (0 0) (1 0) (2 2))
  (origs (n (2 0)))
  (comment "4 in cohort - 4 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (precedes ((1 0) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation collapsed 1 0)
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k))))
  (label 1)
  (parent 0)
  (seen 3)
  (unrealized (0 0) (1 2))
  (comment "3 in cohort - 2 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0)) ((3 2) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans1 3) n (2 2) (enc n B k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 2)
  (parent 0)
  (unrealized (0 0) (1 0) (2 2) (3 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (precedes ((0 1) (2 2)) ((2 0) (0 0)) ((2 0) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 0 trans2 2) n (2 2) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k))))
  (label 3)
  (parent 0)
  (unrealized (0 0) (1 0))
  (origs (n (2 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (precedes ((1 1) (2 2)) ((2 0) (0 0)) ((2 0) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 1 trans2 2) n (2 2) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k))))
  (label 4)
  (parent 0)
  (unrealized (0 0) (1 0))
  (origs (n (2 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans2 2) n (2 2) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 5)
  (parent 0)
  (unrealized (0 0) (1 0) (3 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((1 0) (0 0)) ((1 0) (2 0)) ((2 2) (1 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans1 3) n (1 2) (enc n B k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 6)
  (parent 1)
  (unrealized (0 0) (1 2) (2 1))
  (origs (n (1 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (precedes ((0 1) (1 2)) ((1 0) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 2 0 trans2 2) n (1 2) (enc n B k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k))))
  (label 7)
  (parent 1)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0)) ((2 1) (3 1))
    ((3 2) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (3 1) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 8)
  (parent 2)
  (seen 15)
  (unrealized (0 0) (1 0) (2 2))
  (comment "4 in cohort - 3 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (precedes ((0 1) (2 2)) ((2 0) (0 0)) ((2 1) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 2 orig 2) n (1 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k))))
  (label 9)
  (parent 3)
  (unrealized (0 0))
  (origs (n (2 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (precedes ((1 1) (2 2)) ((2 0) (0 0)) ((2 1) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 2 orig 2) n (1 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k))))
  (label 10)
  (parent 4)
  (unrealized (0 0))
  (origs (n (2 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 1) (3 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (3 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 11)
  (parent 5)
  (unrealized (0 0) (1 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((1 0) (0 0)) ((1 0) (2 0)) ((1 1) (2 1)) ((2 2) (1 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 1 orig 2) n (2 1) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 12)
  (parent 6)
  (seen 15)
  (unrealized (0 0) (1 2))
  (origs (n (1 0)))
  (comment "3 in cohort - 2 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (precedes ((0 1) (1 2)) ((1 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 2 1 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k))))
  (label 13)
  (parent 7)
  (unrealized)
  (shape)
  (maps ((0 0 1) ((n n) (A B) (B B) (k k))))
  (origs (n (1 0))))

(defskeleton nonaug-prune
  (vars (n text) (B C C-0 name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (defstrand trans1 3 (n n) (A B) (C C-0) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0)) ((2 0) (4 0))
    ((2 1) (3 1)) ((3 2) (2 2)) ((4 2) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans1 3) n (2 2) (enc n B k)
    (enc n n C k) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C-0 k))))
  (label 14)
  (parent 8)
  (seen 8)
  (unrealized (0 0) (1 0) (2 2) (4 1))
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((0 1) (2 2)) ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0))
    ((2 1) (3 1)) ((3 2) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 0 trans2 2) n (2 2) (enc n B k)
    (enc n n C k) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 15)
  (parent 8)
  (unrealized (0 0) (1 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0)) ((2 0) (4 0))
    ((2 1) (3 1)) ((3 2) (2 2)) ((4 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans2 2) n (2 2) (enc n B k)
    (enc n n C k) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k)))
    ((recv (enc n B k)) (send (enc n B B B k))))
  (label 16)
  (parent 8)
  (unrealized (0 0) (1 0) (4 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (precedes ((0 1) (2 2)) ((2 1) (0 0)) ((2 1) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 2 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k))))
  (label 17)
  (parent 9)
  (unrealized)
  (shape)
  (maps ((0 1 2) ((n n) (A B) (B B) (k k))))
  (origs (n (2 0))))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (precedes ((1 1) (2 2)) ((2 1) (0 0)) ((2 1) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 2 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k))))
  (label 18)
  (parent 10)
  (seen 17)
  (unrealized (0 0))
  (origs (n (2 0)))
  (comment "3 in cohort - 2 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 0) (0 0)) ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (1 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 19)
  (parent 11)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C C-0 name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (defstrand trans1 3 (n n) (A B) (C C-0) (k k))
  (precedes ((1 0) (0 0)) ((1 0) (2 0)) ((1 0) (3 0)) ((1 1) (2 1))
    ((2 2) (1 2)) ((3 2) (1 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans1 3) n (1 2) (enc n B k)
    (enc n n C k) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C-0 k))))
  (label 20)
  (parent 12)
  (seen 12)
  (unrealized (0 0) (1 2) (3 1))
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((0 1) (1 2)) ((1 0) (0 0)) ((1 0) (2 0)) ((1 1) (2 1))
    ((2 2) (1 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 0 trans2 2) n (1 2) (enc n B k)
    (enc n n C k) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 21)
  (parent 12)
  (unrealized (0 0))
  (origs (n (1 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((0 1) (2 2)) ((2 0) (0 0)) ((2 0) (3 0)) ((2 1) (1 0))
    ((2 1) (3 1)) ((3 2) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (1 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 22)
  (parent 15)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (1 0)) ((2 0) (3 0)) ((2 1) (3 1))
    ((2 1) (4 0)) ((3 2) (2 2)) ((4 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 5 2 orig 2) n (4 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k)))
    ((recv (enc n B k)) (send (enc n B B B k))))
  (label 23)
  (parent 16)
  (unrealized (0 0) (1 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (precedes ((1 1) (0 0)) ((1 1) (2 2)) ((2 1) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 1 trans2 2) n (0 0) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k))))
  (label 24)
  (parent 18)
  (unrealized (0 0))
  (origs (n (2 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((1 1) (2 2)) ((2 0) (3 0)) ((2 1) (0 0)) ((2 1) (1 0))
    ((3 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans2 2) n (0 0) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 25)
  (parent 18)
  (unrealized (0 0) (3 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 1) (0 0)) ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 26)
  (parent 19)
  (seen 31)
  (unrealized (0 0))
  (comment "4 in cohort - 3 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((0 1) (1 2)) ((1 0) (2 0)) ((1 1) (0 0)) ((1 1) (2 1))
    ((2 2) (1 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 3 1 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 27)
  (parent 21)
  (seen 13)
  (unrealized)
  (origs (n (1 0)))
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (precedes ((0 1) (2 2)) ((2 0) (3 0)) ((2 1) (0 0)) ((2 1) (1 0))
    ((2 1) (3 1)) ((3 2) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k))))
  (label 28)
  (parent 22)
  (seen 17)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (precedes ((2 0) (0 0)) ((2 0) (3 0)) ((2 1) (1 0)) ((2 1) (3 1))
    ((2 1) (4 0)) ((3 2) (2 2)) ((4 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 5 2 orig 2) n (1 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k)))
    ((recv (enc n B k)) (send (enc n B B B k))))
  (label 29)
  (parent 23)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A name) (k akey))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B A) (k k))
  (precedes ((1 1) (0 0)) ((1 1) (2 2)) ((2 1) (1 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (contracted (B A)) n (0 0) (enc n A k)
    (enc n A A k) (enc n A A A k))
  (traces ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n A A k)) (send (enc n A k)) (recv (enc n A A A k))))
  (label 30)
  (parent 24)
  (seen 17)
  (unrealized)
  (origs (n (2 0)))
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((1 1) (2 2)) ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 2 orig 2) n (3 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 31)
  (parent 25)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A name) (k akey))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 1) (0 0)) ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (contracted (B A)) n (0 0) (enc n A k)
    (enc n A A k))
  (traces ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n A A k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 32)
  (parent 26)
  (unrealized)
  (shape)
  (maps ((0 1 2) ((n n) (A A) (B A) (k k))))
  (origs (n (2 0))))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (0 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 4 3 trans2 2) n (0 0) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 33)
  (parent 26)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 0) (4 0)) ((2 1) (0 0)) ((2 1) (1 0)) ((2 1) (3 0))
    ((3 1) (2 2)) ((4 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (added-strand trans2 2) n (0 0) (enc n A k)
    (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 34)
  (parent 26)
  (unrealized (0 0) (4 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (B C name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand orig 3 (n n) (A B) (B B) (k k))
  (defstrand trans1 3 (n n) (A B) (C C) (k k))
  (defstrand trans2 2 (n n) (A B) (k k))
  (precedes ((2 0) (3 0)) ((2 1) (0 0)) ((2 1) (1 0)) ((2 1) (3 1))
    ((2 1) (4 0)) ((3 2) (2 2)) ((4 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 5 2 orig 2) n (0 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n B k)) (send (enc n B B B k)))
    ((send (enc n B B k)) (send (enc n B k)) (recv (enc n B B B k)))
    ((recv (enc n B B k)) (recv (enc n B k)) (send (enc n n C k)))
    ((recv (enc n B k)) (send (enc n B B B k))))
  (label 35)
  (parent 29)
  (seen 32)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A name) (k akey))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((1 1) (2 2)) ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (contracted (B A)) n (0 0) (enc n A k)
    (enc n A A k) (enc n A A A k))
  (traces ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n A A k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 36)
  (parent 31)
  (seen 17)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A name) (k akey))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 1) (1 0)) ((2 1) (3 0)) ((3 1) (0 0)) ((3 1) (2 2)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (contracted (B A)) n (0 0) (enc n A k)
    (enc n A A k) (enc n A A A k))
  (traces ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n A A k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 37)
  (parent 33)
  (seen 32)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A B name) (k akey))
  (defstrand trans2 2 (n n) (A B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B B) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 1) (1 0)) ((2 1) (3 0)) ((2 1) (4 0)) ((3 1) (2 2))
    ((4 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (displaced 5 2 orig 2) n (4 0) (enc n B B k))
  (traces ((recv (enc n B k)) (send (enc n B B B k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n B B k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 38)
  (parent 34)
  (unrealized (0 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton nonaug-prune
  (vars (n text) (A name) (k akey))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand orig 3 (n n) (A A) (B A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (defstrand trans2 2 (n n) (A A) (k k))
  (precedes ((2 1) (1 0)) ((2 1) (3 0)) ((2 1) (4 0)) ((3 1) (2 2))
    ((4 1) (0 0)))
  (non-orig (invk k))
  (uniq-orig n)
  (operation nonce-test (contracted (B A)) n (0 0) (enc n A k)
    (enc n A A k) (enc n A A A k))
  (traces ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((send (enc n A A k)) (send (enc n A k)) (recv (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k)))
    ((recv (enc n A k)) (send (enc n A A A k))))
  (label 39)
  (parent 38)
  (seen 32)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(comment "Nothing left to do")
