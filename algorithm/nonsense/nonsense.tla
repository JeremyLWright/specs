------------------------------ MODULE nonsense ------------------------------

EXTENDS TLC, Integers


VARIABLES A

vars == A

Init == A = 1

Next == A' = 1

EventuallyRubbish == <>(A = 999)

Spec == Init /\ [][Next]_vars /\ <>[](A = 0)


=============================================================================
\* Modification History
\* Last modified Fri Oct 29 13:23:18 MST 2021 by jeremy
\* Created Fri Oct 29 13:08:26 MST 2021 by jeremy
