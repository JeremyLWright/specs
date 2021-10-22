---- MODULE sort ----

EXTENDS TLC, Integers, Folds, Sequences, SequencesExt, FiniteSetsExt


CONSTANTS N

VARIABLES A 

IsSorted(seq) == \A a,b \in 1..Len(seq): a <= b => seq[a] <= seq[b]
ApplyIndices(seq, indices) == [ i \in 1..Len(seq) |-> seq[indices[i]]]
PermutationsSeq(seq) == {ApplyIndices(seq, p) : p \in Permutations(1..Len(seq))}

SortByMagic(seq) == CHOOSE p \in PermutationsSeq(seq) : IsSorted(p)

vars == <<A>>

Init == A \in [1..N -> Int]

Next == A' = SortByMagic(A) 

Spec == Init /\ [][Next]_vars /\ <>[]IsSorted(A)

TypeOK == Len(A) = N

====