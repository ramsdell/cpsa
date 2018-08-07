(herald "Diffie-Hellman enhanced Needham-Schroeder-Lowe Protocol"
  (algebra basic))

(comment "CPSA 4.1.2")
(comment "All input read from dhnsl_hack.scm")

(defprotocol dhnsl basic
  (defrole init
    (vars (a b name) (h2 h3 gx akey) (dhkey skey))
    (trace (send (enc gx a (pubk b)))
      (recv (enc h2 (enc "dh" h2 gx dhkey) h3 b (pubk a)))
      (send (enc (enc "dh" h3 gx dhkey) (pubk b))))
    (non-orig dhkey (invk gx))
    (uniq-orig gx)
    (comment "X should be assumed to be freshly chosen per role"))
  (defrole resp
    (vars (b a name) (h1 gy gz akey) (dhkey skey))
    (trace (recv (enc h1 a (pubk b)))
      (send (enc gy (enc "dh" gy h1 dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz h1 dhkey) (pubk b))))
    (non-orig dhkey (invk gy) (invk gz))
    (uniq-orig gy gz)
    (comment "Y and Z should be assumed to be freshly chosen per role"))
  (comment
    "Needham-Schroeder-Lowe DH challenge/responses in place of nonces"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy gz akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (non-orig dhkey (invk gx) (privk a) (privk b))
  (uniq-orig gx)
  (comment "Initiator point-of-view")
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b)))))
  (label 0)
  (unrealized (0 1))
  (origs (gx (0 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b b-0 a-0 name) (dhkey skey) (gx gy gz gz-0 akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (defstrand resp 2 (b b-0) (a a-0) (dhkey dhkey) (h1 gx) (gy gy)
    (gz gz-0))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz-0) (privk a) (privk b))
  (uniq-orig gx gy gz-0)
  (operation encryption-test (added-strand resp 2)
    (enc "dh" gy gx dhkey) (0 1))
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((recv (enc gx a-0 (pubk b-0)))
      (send (enc gy (enc "dh" gy gx dhkey) gz-0 b-0 (pubk a-0)))))
  (label 1)
  (parent 0)
  (unrealized (1 0))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy gz gz-0 akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz-0))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz-0) (privk a) (privk b))
  (uniq-orig gx gy gz-0)
  (operation nonce-test (contracted (b-0 b) (a-0 a)) gx (1 0)
    (enc gx a (pubk b)))
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz-0 b (pubk a)))))
  (label 2)
  (parent 1)
  (unrealized (0 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b b-0 a-0 name) (dhkey dhkey-0 skey)
    (gx gy gz gz-0 gy-0 gz-1 akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (defstrand resp 2 (b b-0) (a a-0) (dhkey dhkey) (h1 gx) (gy gy)
    (gz gz-0))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey-0) (h1 gx) (gy gy-0)
    (gz gz-1))
  (precedes ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (1 0)))
  (non-orig dhkey dhkey-0 (invk gx) (invk gy) (invk gz-0) (invk gy-0)
    (invk gz-1) (privk a) (privk b))
  (uniq-orig gx gy gz-0 gy-0 gz-1)
  (operation nonce-test (added-strand resp 2) gx (1 0)
    (enc gx a (pubk b)))
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((recv (enc gx a-0 (pubk b-0)))
      (send (enc gy (enc "dh" gy gx dhkey) gz-0 b-0 (pubk a-0))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy-0 (enc "dh" gy-0 gx dhkey-0) gz-1 b (pubk a)))))
  (label 3)
  (parent 1)
  (unrealized (1 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy gz akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz) (privk a) (privk b))
  (uniq-orig gx gy gz)
  (operation encryption-test (contracted (gz-0 gz))
    (enc "dh" gy gx dhkey) (0 1)
    (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))))
  (label 4)
  (parent 2)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (gx gx) (gy gy) (gz gz) (dhkey dhkey))))
  (origs (gy (1 1)) (gz (1 1)) (gx (0 0))))

(defskeleton dhnsl
  (vars (a b name) (dhkey dhkey-0 skey) (gx gy gz gz-0 gy-0 gz-1 akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz-0))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey-0) (h1 gx) (gy gy-0)
    (gz gz-1))
  (precedes ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (1 0)))
  (non-orig dhkey dhkey-0 (invk gx) (invk gy) (invk gz-0) (invk gy-0)
    (invk gz-1) (privk a) (privk b))
  (uniq-orig gx gy gz-0 gy-0 gz-1)
  (operation nonce-test (contracted (b-0 b) (a-0 a)) gx (1 0)
    (enc gx a (pubk b))
    (enc gy-0 (enc "dh" gy-0 gx dhkey-0) gz-1 b (pubk a)))
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz-0 b (pubk a))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy-0 (enc "dh" gy-0 gx dhkey-0) gz-1 b (pubk a)))))
  (label 5)
  (parent 3)
  (unrealized (0 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b name) (dhkey dhkey-0 skey) (gx gy gz gy-0 gz-0 akey))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (defstrand resp 2 (b b) (a a) (dhkey dhkey-0) (h1 gx) (gy gy-0)
    (gz gz-0))
  (precedes ((0 0) (2 0)) ((1 1) (0 1)) ((2 1) (1 0)))
  (non-orig dhkey dhkey-0 (invk gx) (invk gy) (invk gz) (invk gy-0)
    (invk gz-0) (privk a) (privk b))
  (uniq-orig gx gy gz gy-0 gz-0)
  (operation encryption-test (contracted (gz-1 gz))
    (enc "dh" gy gx dhkey) (0 1)
    (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
  (traces
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a))))
    ((recv (enc gx a (pubk b)))
      (send (enc gy-0 (enc "dh" gy-0 gx dhkey-0) gz-0 b (pubk a)))))
  (label 6)
  (parent 5)
  (seen 4)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(comment "Nothing left to do")

(defprotocol dhnsl basic
  (defrole init
    (vars (a b name) (h2 h3 gx akey) (dhkey skey))
    (trace (send (enc gx a (pubk b)))
      (recv (enc h2 (enc "dh" h2 gx dhkey) h3 b (pubk a)))
      (send (enc (enc "dh" h3 gx dhkey) (pubk b))))
    (non-orig dhkey (invk gx))
    (uniq-orig gx)
    (comment "X should be assumed to be freshly chosen per role"))
  (defrole resp
    (vars (b a name) (h1 gy gz akey) (dhkey skey))
    (trace (recv (enc h1 a (pubk b)))
      (send (enc gy (enc "dh" gy h1 dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz h1 dhkey) (pubk b))))
    (non-orig dhkey (invk gy) (invk gz))
    (uniq-orig gy gz)
    (comment "Y and Z should be assumed to be freshly chosen per role"))
  (comment
    "Needham-Schroeder-Lowe DH challenge/responses in place of nonces"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy gz akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (non-orig dhkey (invk gy) (invk gz) (privk a))
  (uniq-orig gy gz)
  (comment "Responder point-of-view")
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz gx dhkey) (pubk b)))))
  (label 7)
  (unrealized (0 2))
  (origs (gz (0 1)) (gy (0 1)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton dhnsl
  (vars (a b a-0 b-0 name) (dhkey skey) (gx gy gz h2 akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (defstrand init 3 (a a-0) (b b-0) (dhkey dhkey) (h2 h2) (h3 gz)
    (gx gx))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 2) (0 2)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz) (privk a))
  (uniq-orig gx gy gz)
  (operation encryption-test (added-strand init 3)
    (enc "dh" gz gx dhkey) (0 2))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((send (enc gx a-0 (pubk b-0)))
      (recv (enc h2 (enc "dh" h2 gx dhkey) gz b-0 (pubk a-0)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b-0)))))
  (label 8)
  (parent 7)
  (unrealized (1 1))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gy))
  (non-orig dhkey (invk gy) (privk a))
  (uniq-orig gy)
  (operation encryption-test (displaced 1 0 resp 2)
    (enc "dh" gz gx dhkey) (0 2))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
      (recv (enc (enc "dh" gy gx dhkey) (pubk b)))))
  (label 9)
  (parent 7)
  (unrealized (0 2))
  (origs (gy (0 1)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b a-0 b-0 name) (dhkey skey) (gx gy gz akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (defstrand init 3 (a a-0) (b b-0) (dhkey dhkey) (h2 gy) (h3 gz)
    (gx gx))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 2) (0 2)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz) (privk a))
  (uniq-orig gx gy gz)
  (operation encryption-test (displaced 2 0 resp 2)
    (enc "dh" h2 gx dhkey) (1 1))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((send (enc gx a-0 (pubk b-0)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b-0 (pubk a-0)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b-0)))))
  (label 10)
  (parent 8)
  (unrealized (1 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b a-0 b-0 b-1 a-1 name) (dhkey skey) (gx gy gz h2 gz-0 akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (defstrand init 3 (a a-0) (b b-0) (dhkey dhkey) (h2 h2) (h3 gz)
    (gx gx))
  (defstrand resp 2 (b b-1) (a a-1) (dhkey dhkey) (h1 gx) (gy h2)
    (gz gz-0))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 0) (2 0)) ((1 2) (0 2))
    ((2 1) (1 1)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz) (invk h2) (invk gz-0)
    (privk a))
  (uniq-orig gx gy gz h2 gz-0)
  (operation encryption-test (added-strand resp 2)
    (enc "dh" h2 gx dhkey) (1 1))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((send (enc gx a-0 (pubk b-0)))
      (recv (enc h2 (enc "dh" h2 gx dhkey) gz b-0 (pubk a-0)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b-0))))
    ((recv (enc gx a-1 (pubk b-1)))
      (send (enc h2 (enc "dh" h2 gx dhkey) gz-0 b-1 (pubk a-1)))))
  (label 11)
  (parent 8)
  (unrealized (1 1))
  (comment "empty cohort"))

(defskeleton dhnsl
  (vars (a b a-0 b-0 name) (dhkey skey) (gx gy h2 akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gy))
  (defstrand init 3 (a a-0) (b b-0) (dhkey dhkey) (h2 h2) (h3 gy)
    (gx gx))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 2) (0 2)))
  (non-orig dhkey (invk gx) (invk gy) (privk a))
  (uniq-orig gx gy)
  (operation encryption-test (added-strand init 3)
    (enc "dh" gy gx dhkey) (0 2)
    (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
      (recv (enc (enc "dh" gy gx dhkey) (pubk b))))
    ((send (enc gx a-0 (pubk b-0)))
      (recv (enc h2 (enc "dh" h2 gx dhkey) gy b-0 (pubk a-0)))
      (send (enc (enc "dh" gy gx dhkey) (pubk b-0)))))
  (label 12)
  (parent 9)
  (unrealized (1 1))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy gz akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gz))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gz) (gx gx))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 2) (0 2)))
  (non-orig dhkey (invk gx) (invk gy) (invk gz) (privk a))
  (uniq-orig gx gy gz)
  (operation encryption-test (contracted (a-0 a) (b-0 b))
    (enc "dh" gy gx dhkey) (1 1)
    (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (recv (enc (enc "dh" gz gx dhkey) (pubk b))))
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gz b (pubk a)))
      (send (enc (enc "dh" gz gx dhkey) (pubk b)))))
  (label 13)
  (parent 10)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (gx gx) (gy gy) (gz gz) (dhkey dhkey))))
  (origs (gy (0 1)) (gz (0 1)) (gx (1 0))))

(defskeleton dhnsl
  (vars (a b a-0 b-0 name) (dhkey skey) (gx gy akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gy))
  (defstrand init 3 (a a-0) (b b-0) (dhkey dhkey) (h2 gy) (h3 gy)
    (gx gx))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 2) (0 2)))
  (non-orig dhkey (invk gx) (invk gy) (privk a))
  (uniq-orig gx gy)
  (operation encryption-test (displaced 2 0 resp 2)
    (enc "dh" h2 gx dhkey) (1 1))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
      (recv (enc (enc "dh" gy gx dhkey) (pubk b))))
    ((send (enc gx a-0 (pubk b-0)))
      (recv (enc gy (enc "dh" gy gx dhkey) gy b-0 (pubk a-0)))
      (send (enc (enc "dh" gy gx dhkey) (pubk b-0)))))
  (label 14)
  (parent 12)
  (unrealized (1 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton dhnsl
  (vars (a b a-0 b-0 b-1 a-1 name) (dhkey skey) (gx gy h2 gz akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gy))
  (defstrand init 3 (a a-0) (b b-0) (dhkey dhkey) (h2 h2) (h3 gy)
    (gx gx))
  (defstrand resp 2 (b b-1) (a a-1) (dhkey dhkey) (h1 gx) (gy h2)
    (gz gz))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 0) (2 0)) ((1 2) (0 2))
    ((2 1) (1 1)))
  (non-orig dhkey (invk gx) (invk gy) (invk h2) (invk gz) (privk a))
  (uniq-orig gx gy h2 gz)
  (operation encryption-test (added-strand resp 2)
    (enc "dh" h2 gx dhkey) (1 1))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
      (recv (enc (enc "dh" gy gx dhkey) (pubk b))))
    ((send (enc gx a-0 (pubk b-0)))
      (recv (enc h2 (enc "dh" h2 gx dhkey) gy b-0 (pubk a-0)))
      (send (enc (enc "dh" gy gx dhkey) (pubk b-0))))
    ((recv (enc gx a-1 (pubk b-1)))
      (send (enc h2 (enc "dh" h2 gx dhkey) gz b-1 (pubk a-1)))))
  (label 15)
  (parent 12)
  (unrealized (1 1))
  (comment "empty cohort"))

(defskeleton dhnsl
  (vars (a b name) (dhkey skey) (gx gy akey))
  (defstrand resp 3 (b b) (a a) (dhkey dhkey) (h1 gx) (gy gy) (gz gy))
  (defstrand init 3 (a a) (b b) (dhkey dhkey) (h2 gy) (h3 gy) (gx gx))
  (precedes ((0 1) (1 1)) ((1 0) (0 0)) ((1 2) (0 2)))
  (non-orig dhkey (invk gx) (invk gy) (privk a))
  (uniq-orig gx gy)
  (operation encryption-test (contracted (a-0 a) (b-0 b))
    (enc "dh" gy gx dhkey) (1 1)
    (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
  (traces
    ((recv (enc gx a (pubk b)))
      (send (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
      (recv (enc (enc "dh" gy gx dhkey) (pubk b))))
    ((send (enc gx a (pubk b)))
      (recv (enc gy (enc "dh" gy gx dhkey) gy b (pubk a)))
      (send (enc (enc "dh" gy gx dhkey) (pubk b)))))
  (label 16)
  (parent 14)
  (seen 13)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(comment "Nothing left to do")
