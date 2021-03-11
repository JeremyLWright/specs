-------------------------------- MODULE GCD --------------------------------

EXTENDS Integers

Divides(p, n) == \E q \in Int : n = q * p \* We cannot define division, so we do the reverse n/p \in Int

DivisorsOf(n) == {p \in Int : Divides(p, n)}

SetMax(S) == 
    CHOOSE i \in S : \A j \in S : i >= j

GCD(m,n) == SetMax(DivisorsOf(m) \cap DivisorsOf(n))



TypeOK == 
    /\ DivisorsOf(493) = <<-493, -29, -17, -1, 1, 17, 29, 493>>

=============================================================================
\* Modification History
\* Last modified Tue Mar 09 21:40:00 MST 2021 by jerem
\* Created Tue Mar 09 21:25:14 MST 2021 by jerem
