-------------------------------- MODULE GCD --------------------------------

EXTENDS Integers, Naturals

Divides(p, n) == \E q \in Int : n = q * p \* We cannot define division, so we do the reverse n/p \in Int

DivisorsOf(n) == {p \in Int : Divides(p, n)}

SetMax(S) == 
    CHOOSE i \in S : \A j \in S : i >= j

GCD(m,n) == SetMax(DivisorsOf(m) \cap DivisorsOf(n))

SetGCD(T) == SetMax({d \in Int : \A t \in T : Divides(d, t)})


=============================================================================
\* Modification History
\* Last modified Wed Mar 10 23:07:58 MST 2021 by jerem
\* Created Tue Mar 09 21:25:14 MST 2021 by jerem
