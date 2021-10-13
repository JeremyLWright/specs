---- MODULE snoc ----
EXTENDS TLC, Sequences, SequencesExt, Integers

CONSTANTS N

VARIABLES A

IntRange == 1..5

vars == <<A>>

\* Isabelle/HOL Exercises (https://isabelle.in.tum.de/exercises/)

\* Define a primitive recursive function snoc that appends an element at the right end of a
\* list. Do not use @ itself.

snoc(as, a) == as \o <<a>>

Init == 
    /\ A \in [1..N -> Int]

Next ==
    /\ Len(snoc(A, 2)) = 6
    /\ UNCHANGED A

Spec == Init /\ [][Next]_vars

Rev_cons == \A a \in 1..N : Reverse(Cons(A[a], A)) = snoc(Reverse(A), A[a])


\* Prove the following theorem:
THEOREM Rev_cons
    PROOF OBVIOUS 

\* Hint: you need to prove a suitable lemma first.



====