---------------------------- MODULE OneBitClock ----------------------------

VARIABLE b

Init1 == (b = 0) \/ (b = 1)
Next1 == \/ /\ b  = 0
            /\ b' = 1
         \/ /\ b  = 1
            /\ b' = 0
                   
=============================================================================
\* Modification History
\* Last modified Fri Feb 26 23:26:59 MST 2021 by jeremy
\* Created Fri Feb 26 23:17:57 MST 2021 by jeremy
