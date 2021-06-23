-------------------------- MODULE stm ----------------------------

VARIABLES box

vars == <<box>>

BoxStates == {"uncommitted", "committed"}

Committed == box[2] = "committed"

Init == box = <<{}, "uncommitted">>

Next == \/ ~Committed
        \/ Committed
            /\ UNCHANGED vars
    
Spec == Init /\ [][Next]_vars


BoxStatesAreValid == box[2] \in BoxStates

TypeOk == /\ BoxStatesAreValid
    



==================================================================