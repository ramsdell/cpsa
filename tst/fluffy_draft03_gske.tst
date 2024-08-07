(herald
  "GSKE, part of Fluffy: Simplified Key Exchange for Constrained Environments draft-hardjono-ace-fluffy-03"
  (comment
    "Based on the Internet-Draft: https://www.ietf.org/archive/id/draft-hardjono-ace-fluffy-03.txt"))

(comment "CPSA 4.2.4")
(comment "All input read from tst/fluffy_draft03_gske.scm")

(defprotocol fluffy basic
  (defrole sp
    (vars (b s name) (nb g text) (gk skey))
    (trace (send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (defrole keyserv
    (vars (a b s name) (nb na g text) (gk skey))
    (trace (recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    (uniq-gen gk))
  (defrole client
    (vars (a s name) (na g text) (gk skey))
    (trace (send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a)))))))

(defskeleton fluffy
  (vars (nb g text) (b s name) (gk skey))
  (defstrand sp 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (non-orig (ltk s b))
  (uniq-orig nb)
  (comment "Service Principal's point-of-view")
  (traces
    ((send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (label 0)
  (unrealized (0 1))
  (origs (nb (0 0)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton fluffy
  (vars (nb g nb-0 text) (b s b-0 name) (gk skey))
  (defstrand sp 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (defstrand keyserv 4 (nb nb-0) (na nb) (g g) (a b) (b b-0) (s s)
    (gk gk))
  (precedes ((0 0) (1 2)) ((1 3) (0 1)))
  (non-orig (ltk s b))
  (uniq-orig nb)
  (operation encryption-test (added-strand keyserv 4)
    (enc s g nb gk (ltk s b)) (0 1))
  (traces
    ((send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b)))))
    ((recv (cat "req" s g (enc b-0 nb-0 (ltk s b-0))))
      (send (cat "resp" b-0 (enc s g nb-0 gk (ltk s b-0))))
      (recv (cat "fetch" s g (enc b nb (ltk s b))))
      (send (cat "deliver" b (enc s g nb gk (ltk s b))))))
  (label 1)
  (parent 0)
  (unrealized)
  (shape)
  (maps ((0) ((b b) (s s) (nb nb) (gk gk) (g g))))
  (origs (nb (0 0))))

(defskeleton fluffy
  (vars (nb g text) (b s name) (gk skey))
  (defstrand sp 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (defstrand keyserv 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig (ltk s b))
  (uniq-orig nb)
  (operation encryption-test (added-strand keyserv 2)
    (enc s g nb gk (ltk s b)) (0 1))
  (traces
    ((send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b)))))
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))))
  (label 2)
  (parent 0)
  (unrealized)
  (shape)
  (maps ((0) ((b b) (s s) (nb nb) (gk gk) (g g))))
  (origs (nb (0 0))))

(comment "Nothing left to do")

(defprotocol fluffy basic
  (defrole sp
    (vars (b s name) (nb g text) (gk skey))
    (trace (send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (defrole keyserv
    (vars (a b s name) (nb na g text) (gk skey))
    (trace (recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    (uniq-gen gk))
  (defrole client
    (vars (a s name) (na g text) (gk skey))
    (trace (send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a)))))))

(defskeleton fluffy
  (vars (nb na g text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (non-orig (ltk s a) (ltk s b))
  (comment "SKDC's point-of-view")
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a))))))
  (label 3)
  (unrealized (0 0) (0 2))
  (origs)
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton fluffy
  (vars (nb na g g-0 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand sp 1 (nb nb) (g g-0) (b b) (s s))
  (precedes ((1 0) (0 0)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand sp 1) (enc b nb (ltk s b))
    (0 0))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "req" s g-0 (enc b nb (ltk s b))))))
  (label 4)
  (parent 3)
  (unrealized (0 2))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton fluffy
  (vars (nb na g g-0 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand client 1 (na nb) (g g-0) (a b) (s s))
  (precedes ((1 0) (0 0)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand client 1)
    (enc b nb (ltk s b)) (0 0))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "fetch" s g-0 (enc b nb (ltk s b))))))
  (label 5)
  (parent 3)
  (unrealized (0 2))
  (comment "3 in cohort - 3 not yet seen"))

(defskeleton fluffy
  (vars (nb g g-0 text) (b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na nb) (g g) (a b) (b b) (s s) (gk gk))
  (defstrand sp 1 (nb nb) (g g-0) (b b) (s s))
  (precedes ((1 0) (0 0)))
  (non-orig (ltk s b))
  (operation encryption-test (displaced 2 1 sp 1) (enc a na (ltk s a))
    (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc b nb (ltk s b))))
      (send (cat "deliver" b (enc s g nb gk (ltk s b)))))
    ((send (cat "req" s g-0 (enc b nb (ltk s b))))))
  (label 6)
  (parent 4)
  (unrealized)
  (shape)
  (maps ((0) ((a b) (b b) (s s) (nb nb) (na nb) (gk gk) (g g))))
  (origs))

(defskeleton fluffy
  (vars (nb na g g-0 g-1 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand sp 1 (nb nb) (g g-0) (b b) (s s))
  (defstrand sp 1 (nb na) (g g-1) (b a) (s s))
  (precedes ((1 0) (0 0)) ((2 0) (0 2)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand sp 1) (enc a na (ltk s a))
    (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "req" s g-0 (enc b nb (ltk s b)))))
    ((send (cat "req" s g-1 (enc a na (ltk s a))))))
  (label 7)
  (parent 4)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (s s) (nb nb) (na na) (gk gk) (g g))))
  (origs))

(defskeleton fluffy
  (vars (nb na g g-0 g-1 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand sp 1 (nb nb) (g g-0) (b b) (s s))
  (defstrand client 1 (na na) (g g-1) (a a) (s s))
  (precedes ((1 0) (0 0)) ((2 0) (0 2)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand client 1)
    (enc a na (ltk s a)) (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "req" s g-0 (enc b nb (ltk s b)))))
    ((send (cat "fetch" s g-1 (enc a na (ltk s a))))))
  (label 8)
  (parent 4)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (s s) (nb nb) (na na) (gk gk) (g g))))
  (origs))

(defskeleton fluffy
  (vars (nb na g g-0 g-1 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand client 1 (na nb) (g g-0) (a b) (s s))
  (defstrand sp 1 (nb na) (g g-1) (b a) (s s))
  (precedes ((1 0) (0 0)) ((2 0) (0 2)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand sp 1) (enc a na (ltk s a))
    (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "fetch" s g-0 (enc b nb (ltk s b)))))
    ((send (cat "req" s g-1 (enc a na (ltk s a))))))
  (label 9)
  (parent 5)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (s s) (nb nb) (na na) (gk gk) (g g))))
  (origs))

(defskeleton fluffy
  (vars (nb g g-0 text) (b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na nb) (g g) (a b) (b b) (s s) (gk gk))
  (defstrand client 1 (na nb) (g g-0) (a b) (s s))
  (precedes ((1 0) (0 0)))
  (non-orig (ltk s b))
  (operation encryption-test (displaced 2 1 client 1)
    (enc a na (ltk s a)) (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc b nb (ltk s b))))
      (send (cat "deliver" b (enc s g nb gk (ltk s b)))))
    ((send (cat "fetch" s g-0 (enc b nb (ltk s b))))))
  (label 10)
  (parent 5)
  (unrealized)
  (shape)
  (maps ((0) ((a b) (b b) (s s) (nb nb) (na nb) (gk gk) (g g))))
  (origs))

(defskeleton fluffy
  (vars (nb na g g-0 g-1 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand client 1 (na nb) (g g-0) (a b) (s s))
  (defstrand client 1 (na na) (g g-1) (a a) (s s))
  (precedes ((1 0) (0 0)) ((2 0) (0 2)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand client 1)
    (enc a na (ltk s a)) (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "fetch" s g-0 (enc b nb (ltk s b)))))
    ((send (cat "fetch" s g-1 (enc a na (ltk s a))))))
  (label 11)
  (parent 5)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (s s) (nb nb) (na na) (gk gk) (g g))))
  (origs))

(comment "Nothing left to do")

(defprotocol fluffy basic
  (defrole sp
    (vars (b s name) (nb g text) (gk skey))
    (trace (send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (defrole keyserv
    (vars (a b s name) (nb na g text) (gk skey))
    (trace (recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    (uniq-gen gk))
  (defrole client
    (vars (a s name) (na g text) (gk skey))
    (trace (send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a)))))))

(defskeleton fluffy
  (vars (na g text) (a s name) (gk skey))
  (defstrand client 2 (na na) (g g) (a a) (s s) (gk gk))
  (non-orig (ltk s a))
  (uniq-orig na)
  (comment "Clients's point-of-view")
  (traces
    ((send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a))))))
  (label 12)
  (unrealized (0 1))
  (origs (na (0 0)))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton fluffy
  (vars (na g nb text) (a s b name) (gk skey))
  (defstrand client 2 (na na) (g g) (a a) (s s) (gk gk))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (precedes ((0 0) (1 2)) ((1 3) (0 1)))
  (non-orig (ltk s a))
  (uniq-orig na)
  (operation encryption-test (added-strand keyserv 4)
    (enc s g na gk (ltk s a)) (0 1))
  (traces
    ((send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a))))))
  (label 13)
  (parent 12)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (na na) (gk gk) (g g))))
  (origs (na (0 0))))

(defskeleton fluffy
  (vars (na g text) (a s name) (gk skey))
  (defstrand client 2 (na na) (g g) (a a) (s s) (gk gk))
  (defstrand keyserv 2 (nb na) (g g) (b a) (s s) (gk gk))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig (ltk s a))
  (uniq-orig na)
  (operation encryption-test (added-strand keyserv 2)
    (enc s g na gk (ltk s a)) (0 1))
  (traces
    ((send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((recv (cat "req" s g (enc a na (ltk s a))))
      (send (cat "resp" a (enc s g na gk (ltk s a))))))
  (label 14)
  (parent 12)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (na na) (gk gk) (g g))))
  (origs (na (0 0))))

(comment "Nothing left to do")

(defprotocol fluffy-rule basic
  (defrole sp
    (vars (b s name) (nb g text) (gk skey))
    (trace (send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (defrole keyserv
    (vars (a b s name) (nb na g text) (gk skey))
    (trace (recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    (uniq-gen gk))
  (defrole client
    (vars (a s name) (na g text) (gk skey))
    (trace (send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a))))))
  (defrule client-no-request
    (forall ((a s name) (y z strd))
      (implies
        (and (p "client" z 1) (p "client" "s" z s) (p "client" "a" z a)
          (p "keyserv" y 1) (p "keyserv" "s" y s) (p "keyserv" "b" y a))
        (false))))
  (defrule sp-no-fetch
    (forall ((b s name) (y z strd))
      (implies
        (and (p "sp" z 1) (p "sp" "s" z s) (p "sp" "b" z b)
          (p "keyserv" y 3) (p "keyserv" "s" y s) (p "keyserv" "a" y b))
        (false)))))

(defskeleton fluffy-rule
  (vars (nb g text) (b s name) (gk skey))
  (defstrand sp 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (non-orig (ltk s b))
  (uniq-orig nb)
  (comment "Service Principal's point-of-view")
  (traces
    ((send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (label 15)
  (unrealized (0 1))
  (origs (nb (0 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton fluffy-rule
  (vars (nb g text) (b s name) (gk skey))
  (defstrand sp 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (defstrand keyserv 2 (nb nb) (g g) (b b) (s s) (gk gk))
  (precedes ((0 0) (1 0)) ((1 1) (0 1)))
  (non-orig (ltk s b))
  (uniq-orig nb)
  (operation encryption-test (added-strand keyserv 2)
    (enc s g nb gk (ltk s b)) (0 1))
  (traces
    ((send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b)))))
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))))
  (label 16)
  (parent 15)
  (unrealized)
  (shape)
  (maps ((0) ((b b) (s s) (nb nb) (gk gk) (g g))))
  (origs (nb (0 0))))

(comment "Nothing left to do")

(defprotocol fluffy-rule basic
  (defrole sp
    (vars (b s name) (nb g text) (gk skey))
    (trace (send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (defrole keyserv
    (vars (a b s name) (nb na g text) (gk skey))
    (trace (recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    (uniq-gen gk))
  (defrole client
    (vars (a s name) (na g text) (gk skey))
    (trace (send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a))))))
  (defrule client-no-request
    (forall ((a s name) (y z strd))
      (implies
        (and (p "client" z 1) (p "client" "s" z s) (p "client" "a" z a)
          (p "keyserv" y 1) (p "keyserv" "s" y s) (p "keyserv" "b" y a))
        (false))))
  (defrule sp-no-fetch
    (forall ((b s name) (y z strd))
      (implies
        (and (p "sp" z 1) (p "sp" "s" z s) (p "sp" "b" z b)
          (p "keyserv" y 3) (p "keyserv" "s" y s) (p "keyserv" "a" y b))
        (false)))))

(defskeleton fluffy-rule
  (vars (nb na g text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (non-orig (ltk s a) (ltk s b))
  (comment "SKDC's point-of-view")
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a))))))
  (label 17)
  (unrealized (0 0) (0 2))
  (origs)
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton fluffy-rule
  (vars (nb na g g-0 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand sp 1 (nb nb) (g g-0) (b b) (s s))
  (precedes ((1 0) (0 0)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand sp 1) (enc b nb (ltk s b))
    (0 0))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "req" s g-0 (enc b nb (ltk s b))))))
  (label 18)
  (parent 17)
  (unrealized (0 2))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton fluffy-rule
  (vars (nb na g g-0 g-1 text) (a b s name) (gk skey))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (defstrand sp 1 (nb nb) (g g-0) (b b) (s s))
  (defstrand client 1 (na na) (g g-1) (a a) (s s))
  (precedes ((1 0) (0 0)) ((2 0) (0 2)))
  (non-orig (ltk s a) (ltk s b))
  (operation encryption-test (added-strand client 1)
    (enc a na (ltk s a)) (0 2))
  (traces
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((send (cat "req" s g-0 (enc b nb (ltk s b)))))
    ((send (cat "fetch" s g-1 (enc a na (ltk s a))))))
  (label 19)
  (parent 18)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (b b) (s s) (nb nb) (na na) (gk gk) (g g))))
  (origs))

(comment "Nothing left to do")

(defprotocol fluffy-rule basic
  (defrole sp
    (vars (b s name) (nb g text) (gk skey))
    (trace (send (cat "req" s g (enc b nb (ltk s b))))
      (recv (cat "resp" b (enc s g nb gk (ltk s b))))))
  (defrole keyserv
    (vars (a b s name) (nb na g text) (gk skey))
    (trace (recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a)))))
    (uniq-gen gk))
  (defrole client
    (vars (a s name) (na g text) (gk skey))
    (trace (send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a))))))
  (defrule client-no-request
    (forall ((a s name) (y z strd))
      (implies
        (and (p "client" z 1) (p "client" "s" z s) (p "client" "a" z a)
          (p "keyserv" y 1) (p "keyserv" "s" y s) (p "keyserv" "b" y a))
        (false))))
  (defrule sp-no-fetch
    (forall ((b s name) (y z strd))
      (implies
        (and (p "sp" z 1) (p "sp" "s" z s) (p "sp" "b" z b)
          (p "keyserv" y 3) (p "keyserv" "s" y s) (p "keyserv" "a" y b))
        (false)))))

(defskeleton fluffy-rule
  (vars (na g text) (a s name) (gk skey))
  (defstrand client 2 (na na) (g g) (a a) (s s) (gk gk))
  (non-orig (ltk s a))
  (uniq-orig na)
  (comment "Clients's point-of-view")
  (traces
    ((send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a))))))
  (label 20)
  (unrealized (0 1))
  (origs (na (0 0)))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton fluffy-rule
  (vars (na g nb text) (a s b name) (gk skey))
  (defstrand client 2 (na na) (g g) (a a) (s s) (gk gk))
  (defstrand keyserv 4 (nb nb) (na na) (g g) (a a) (b b) (s s) (gk gk))
  (precedes ((0 0) (1 2)) ((1 3) (0 1)))
  (non-orig (ltk s a))
  (uniq-orig na)
  (operation encryption-test (added-strand keyserv 4)
    (enc s g na gk (ltk s a)) (0 1))
  (traces
    ((send (cat "fetch" s g (enc a na (ltk s a))))
      (recv (cat "deliver" a (enc s g na gk (ltk s a)))))
    ((recv (cat "req" s g (enc b nb (ltk s b))))
      (send (cat "resp" b (enc s g nb gk (ltk s b))))
      (recv (cat "fetch" s g (enc a na (ltk s a))))
      (send (cat "deliver" a (enc s g na gk (ltk s a))))))
  (label 21)
  (parent 20)
  (unrealized)
  (shape)
  (maps ((0) ((a a) (s s) (na na) (gk gk) (g g))))
  (origs (na (0 0))))

(comment "Nothing left to do")
