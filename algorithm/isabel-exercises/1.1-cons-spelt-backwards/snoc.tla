---- MODULE snoc ----
EXTENDS TLC, Sequences, Integers

CONSTANTS N

VARIABLES A

Reverse(s) ==
  (**************************************************************************)
  (* Reverse the given sequence s:  Let l be Len(s) (length of s).          *)
  (* Equals a sequence s.t. << S[l], S[l-1], ..., S[1]>>                    *)
  (**************************************************************************)
  [ i \in 1..Len(s) |-> s[(Len(s) - i) + 1] ]
  
Cons(elt, seq) == 
    (***************************************************************************)
    (* Cons prepends an element at the beginning of a sequence.                *)
    (***************************************************************************)
    <<elt>> \o seq

IntRange == 1..5

vars == <<A>>

\* Isabelle/HOL Exercises (https://isabelle.in.tum.de/exercises/)

\* Define a primitive recursive function snoc that appends an element at the right end of a
\* list. Do not use @ itself.

[i \in 1..(Len(s) + Len(t)) |-> IF i \leq Len(s) THEN s[i]
                                                           ELSE t[i-Len(s)]]

snoc(as, a) == as \o <<a>>

Init == 
    /\ A \in [1..N -> Int]

Next ==
    /\ A' = snoc(A, 2)
    /\ UNCHANGED A

Spec == Init /\ [][Next]_vars

Rev_cons == \A a \in 1..N : Reverse(Cons(A[a], A)) = snoc(Reverse(A), A[a])


\* Prove the following theorem:
THEOREM Correctness == Spec => []Rev_cons
    PROOF 
    OBVIOUS 

\* Hint: you need to prove a suitable lemma first.



====