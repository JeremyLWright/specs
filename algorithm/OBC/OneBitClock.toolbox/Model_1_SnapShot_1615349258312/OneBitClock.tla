---------------------------- MODULE OneBitClock ----------------------------

VARIABLES b

Init == b \in {0,1}

Next == \/ /\ b = 0
           /\ b' = 1
        \/ /\ b = 1
           /\ b' = 0

=============================================================================
\* Modification History
\* Last modified Tue Mar 09 21:07:14 MST 2021 by jerem
\* Created Tue Mar 09 21:04:34 MST 2021 by jerem
