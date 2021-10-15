---- MODULE sort ----

EXTENDS TLC, Integers, Folds, Sequences, SequencesExt, FiniteSetsExt


CONSTANTS N

VARIABLES A, steps

RECURSIVE SortByMagic(_)
SortByMagic(as) == 
    IF as = <<>> THEN <<>>
    ELSE 
        LET 
            minValue == Min(ToSet(as))
            asWithoutMin == Remove(as, minValue)
        IN <<minValue>> \o SortByMagic( asWithoutMin )
    
vars == <<A, steps>>

Init == /\ steps = "Start"
        \*/\ A = <<7, 9, 1, 4, 5>>
         /\ A \in [1..N -> Int]

Next == 
    \/ steps = "Start"
        /\ A' = SortByMagic(A) 
        /\ steps' = "Done"
    \/ UNCHANGED vars

Spec == Init /\ [][Next]_vars

IsSorted == \A a,b \in 1..N: a < b => A[a] <= A[b]

IsDone == steps = "Done"

SortedWhenDone == IsDone => IsSorted

TypeOK == Len(A) = N


====