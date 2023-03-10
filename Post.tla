-------------------------------- MODULE Post --------------------------------

EXTENDS Naturals

VARIABLES knowledge

vars == <<knowledge>>


Learn == knowledge' = knowledge + 1

Fail == knowledge' = knowledge + 1

Share == knowledge' = knowledge + 1



Init == knowledge = 0

Next == 
    \/ Learn
    \/ Fail
    \/ Share

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)



=============================================================================
\* Modification History
\* Last modified Thu Dec 16 16:15:33 MST 2021 by jeremy
\* Created Thu Dec 16 16:10:23 MST 2021 by jeremy
