---- MODULE sort ----
EXTENDS TLC, Integers, Sequences, SequencesExt, FiniteSetsExt

CONSTANTS N

VARIABLES A, steps

RECURSIVE GenericSort(_)
GenericSort(as) == 
    IF as = <<>> THEN <<>>
    ELSE 
        LET 
            minValue == Min(ToSet(as))
        IN <<minValue>> \o GenericSort( Remove(as, minValue) )
    
vars == <<A, steps>>

Init == /\ steps = 0
        \* /\ A = <<7, 9, 1, 4, 5>>
        /\ A \in [1..N -> Int]

Next == 
    \/ steps = 0
        /\ A' = GenericSort(A) 
        /\ steps = 1
    \/ UNCHANGED vars

Spec == Init /\ [][Next]_vars

IsSortedAlex == \A a,b \in 1..N: a < b => A[a] <= A[b]

IsDone == steps = 1

SortedWhenDone == IsDone => IsSortedAlex

TypeOK == Len(A) = N


====