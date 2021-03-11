---------------------------- MODULE OneBitClock ----------------------------

VARIABLES b

Init == b \in {0,1}

Next == \/ /\ b = 0
           /\ b' = 1
        \/ /\ b = 1
           /\ b' = 0
           
           
Next2 == IF b = 0 THEN b' = 1 ELSE b' = 0

Next1IsNext2 == Next = Next2

=============================================================================
\* Modification History
\* Last modified Tue Mar 09 21:10:23 MST 2021 by jerem
\* Created Tue Mar 09 21:04:34 MST 2021 by jerem
