-------------------------------- MODULE GCD --------------------------------

EXTENDS Integers

Divides(p, n) == \E q \in 1..n : n = q * p \* We cannot define division, so we do the reverse n/p \in Int

GCD(m,n) == FALSE

=============================================================================
\* Modification History
\* Last modified Tue Mar 09 21:32:03 MST 2021 by jerem
\* Created Tue Mar 09 21:25:14 MST 2021 by jerem
