---------------------------- MODULE ShortestPath ----------------------------

EXTENDS SequencesExt, Sequences, Integers, TLC, Naturals, Functions

CONSTANTS N



G == "A" :> {"A","B","C"} @@
     "B" :> {"C"}  @@
     "C" :> {}
     
Start == "A"
End == "C"

AllNodes == {"A","B","C"}
     
VARIABLES Path 

vars == <<Path>>

Init ==
    /\ Path = <<>> \* so stupid
    /\ PrintT(DOMAIN G)
      

\* Dummy algorithm
\* 0. Graph doesn't change. Algorithm builds up a path.
\* 1. Randomly takes some "next node" that isn't connected
\* 2. Property shows that something fails. 

Arrived == Len(Path) > 0 /\ Path[Len(Path)] = End

NoWhereToGo == Range(Path) = DOMAIN G

Next ==
    \/ Arrived 
        /\ UNCHANGED Path
    \/ NoWhereToGo
        /\ UNCHANGED Path
    \* Take a random name and add it to the path.
    \/ \E n \in DOMAIN G : 
        /\ n \notin Range(Path)
        /\ Path' = Append(Path, n)
        
    \* UNCHANGED Path
      
      
Spec == Init /\ [][Next]_vars

ReachesEnd == /\ Len(Path) > 0
              /\ Path[1] = Start 
              /\ Path[Len(Path)] = End
              
TypeOK == 
    \* /\ UNION Range(G) = DOMAIN G
    /\ \A edges \in Range(G) : edges \subseteq DOMAIN G 
    \* /\ \A node \in Range(Path) : node \in DOMAIN G
              
EventuallyReachesEnd ==  <>[]ReachesEnd

=============================================================================
\* Modification History
\* Last modified Fri Mar 25 13:59:09 MST 2022 by jeremy
\* Created Fri Mar 11 08:45:06 MST 2022 by jeremy