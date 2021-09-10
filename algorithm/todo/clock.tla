---- MODULE clock ----
EXTENDS TLC, Sequences, FiniteSets, Integers, Naturals 

CONSTANTS MaxTick, NULL

VARIABLES tick, value, queue

vars == <<tick, value, queue>>

Init ==
     /\ tick = 0
     /\ value = NULL
     /\ queue = {}

Terminated ==
    /\ tick > MaxTick
    /\ UNCHANGED vars

DoUpdate ==
    /\ tick' = tick + 100
    /\ value' = value
    /\ queue' = queue \union {"hello world"}

DoRead ==
    /\ Cardinality(queue) > 0
    /\ tick' = tick + 100
    /\ value' = value
    /\ \E item \in queue : queue' = queue \ {item}

Next ==
    \/ DoUpdate
    \/ DoRead
    \/ Terminated

AlwaysAtLatestValue == TRUE

Spec == Init /\ [][Next]_vars


====