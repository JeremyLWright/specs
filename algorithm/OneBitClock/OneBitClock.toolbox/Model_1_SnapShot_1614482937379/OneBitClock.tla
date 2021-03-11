---------------------------- MODULE OneBitClock ----------------------------

VARIABLE b

Init1 == (b = 0) \/ ( (b = 1) /\ (2 = b) )
Next1 == \/ /\ b  = 0
            /\ b' = 1
         \/ /\ b  = 1
            /\ b' = 0
            
            
TypeOk == b \in {0, 1}
                   
=============================================================================
\* Modification History
\* Last modified Sat Feb 27 20:28:41 MST 2021 by jeremy
\* Created Fri Feb 26 23:17:57 MST 2021 by jeremy
