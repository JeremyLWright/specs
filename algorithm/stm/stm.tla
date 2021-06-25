-------------------------- MODULE stm ----------------------------

EXTENDS Integers, Sequences, FiniteSets

VARIABLES box 

WriteValues == 1..5

vars == <<box>>

BoxStates == {"uncommitted", "committed", "canceled"}




\* The API
Commit == box' = [box EXCEPT !["state"] = "committed"]

Reset == box' = [box EXCEPT !["value"] = box["initial"]]

Cancel == box' = [ box EXCEPT !["state"] = "canceled"]

SetValue(x) == box' = [ box EXCEPT !["value"] = x ]


Init == 
    /\ box = [value |-> 4, state |-> "uncommitted", initial |-> 4]

Committed == box["state"] = "committed"



Next == \/ ~Committed 
            /\ 
                \/ Cancel   
                \/ \E x \in WriteValues : SetValue(x)
                \/ Commit   
                \/ Reset    
        \/ Committed 
            /\ UNCHANGED vars
   
Spec == Init /\ [][Next]_vars

BoxStatesAreValid == box["state"] \in BoxStates

InitialValueNeverChanges == box["initial"] = 4 \* How can I express this?

TypeOk == /\ BoxStatesAreValid
          /\ InitialValueNeverChanges


        \* Express an invariation for john's lost write case, 2 -> 3 -> 2 (why is this bad?)

    

==================================================================