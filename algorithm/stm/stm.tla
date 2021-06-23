-------------------------- MODULE stm ----------------------------

EXTENDS Integers, Sequences, FiniteSets

VARIABLES box, step

vars == <<box, step>>

BoxStates == {"uncommitted", "committed", "canceled"}




\* The API
Commit == box' = [box EXCEPT !["state"] = "committed"]

Reset == box' = [box EXCEPT !["value"] = box["initial"]]

Cancel == box' = [ box EXCEPT !["state"] = "canceled"]

SetValue == \E value \in {1,2,3,5} : 
    box' = [ box EXCEPT !["value"] = value ]


Init == 
    /\ box = [value |-> 4, state |-> "uncommitted", initial |-> 4]
    /\ step = 1

Committed == box["state"] = "committed"

GiveUp == step > 4

NextOp == step' = step + 1

Next == \/ ~GiveUp
            \/ ~Committed  
                /\ SetValue 
                    /\ NextOp
                /\ Commit   
                    /\ NextOp
                /\ Reset    
                    /\ NextOp
                /\ Cancel   
                    /\ NextOp
            \/ Committed 
                /\ UNCHANGED vars
        \/ GiveUp
            /\ UNCHANGED  vars
   
Spec == Init /\ [][Next]_vars

BoxStatesAreValid == box["state"] \in BoxStates

InitialValueNeverChanges == box["initial"] = 4 \* How can I express this?

TypeOk == /\ BoxStatesAreValid
          /\ InitialValueNeverChanges
    

==================================================================