---- MODULE sort ----

EXTENDS TLC, Integers, Folds, Sequences, SequencesExt, FiniteSetsExt


CONSTANTS N

VARIABLES A 

IsSortedAsc(seq) == \A a,b \in 1..N: a < b => seq[a] <= seq[b]
IsSortedDes(seq) == \A a,b \in 1..N: a < b => seq[a] >= seq[b]

ApplyIndices(seq, indices) == [ i \in 1..Len(seq) |-> seq[indices[i]]]
PermutationsSeq(seq) == {ApplyIndices(seq, p) : p \in Permutations(1..Len(seq))}

SortByMagic(seq) == CHOOSE p \in PermutationsSeq(seq) : IsSortedAsc(p)

vars == <<A>>

Init == A = <<2,3,1,4,4>> \* \in [1..N -> Int]

Next == A' = SortByMagic(A) 

EventuallySortedDes ==  <>[]IsSortedDes(A) 
EventuallySortedAsc ==   <>[]IsSortedAsc(A)

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)

TypeOK == Len(A) = N

====