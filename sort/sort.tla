-------------------------------- MODULE sort --------------------------------


EXTENDS TLC, Integers, Folds, Sequences, SequencesExt, FiniteSetsExt

CONSTANT N

ASSUME N > 1

VARIABLES A 

vars == <<A>>

IsSortedAsc(seq) == \A a,b \in 1..N: a < b => seq[a] <= seq[b]
IsSortedDec(seq) == \A a,b \in 1..N: a < b => seq[a] >= seq[b]

ApplyIndicies(seq, indices) == [ i \in 1..Len(seq) |-> seq[indices[i]]]

PermutationsSeq(seq) == {ApplyIndicies(seq, p) : p \in Permutations(1..Len(seq))}

SortByMagic(seq) == CHOOSE p \in PermutationsSeq(seq) : IsSortedAsc(p)

Init == A = <<2,3,4,5,1>>

Init2 == A \in [1..N -> Nat]

Next == A' = SortByMagic(A)

Spec == Init2 /\ [][Next]_vars /\ WF_vars(Next)


EventuallySortedAsc == <>[]IsSortedAsc(A)
EventuallySortedDec == <>[]IsSortedDec(A)

TypeOK == Len(A) = N

=============================================================================
\* Modification History
\* Last modified Fri Feb 11 13:21:02 MST 2022 by jeremy
\* Created Wed Feb 02 09:18:21 MST 2022 by jeremy
