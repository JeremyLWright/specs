--------------------------- MODULE algorithm_max ---------------------------

\* Given a sequence of numbers, return the largest element of that sequence. 
\* Max(<<1,2,3,4,5>>) = 5

EXTENDS Sequences, Integers, TLC
CONSTANTS IntSet, MaxSeqLen
ASSUME IntSet \subseteq Int
ASSUME MaxSeqLen > 0

PT == INSTANCE PT

\* The declarative specification. 
\* We'll base our algorithm against this definition, i.e., operator
Max(seq) ==
    LET set == {seq[i]: i \in 1..Len(seq)}
    IN CHOOSE x \in set: \A y \in set: y <= x \* choose x in the set "such that" for all y in set "such that" y is greater than x

\* Start the Algorithm. Here we'll design an algorithm that imperatively implements max.
\* We'll then use the model checker to check it matches the declarative spec.

 
AllInputs == PT!SeqOf(IntSet, MaxSeqLen) \* Generate an inputset

(*--algorithm max
variables seq \in AllInputs, i = 1, max;
begin
    max := seq[1];
    while i <= Len(seq) do
        if max < seq[i] then
            max := seq[i];
        end if;
        i := i + 1;
    end while;
    assert max = Max(seq) \* check against declarative version
end algorithm *)
\* BEGIN TRANSLATION (chksum(pcal) = "1aaa590b" /\ chksum(tla) = "a573a922")
CONSTANT defaultInitValue
VARIABLES seq, i, max, pc

vars == << seq, i, max, pc >>

Init == (* Global variables *)
        /\ seq \in AllInputs
        /\ i = 1
        /\ max = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ max' = seq[1]
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << seq, i >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF i <= Len(seq)
               THEN /\ IF max < seq[i]
                          THEN /\ max' = seq[i]
                          ELSE /\ TRUE
                               /\ max' = max
                    /\ i' = i + 1
                    /\ pc' = "Lbl_2"
               ELSE /\ Assert(max = Max(seq), 
                              "Failure of assertion at line 35, column 5.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << i, max >>
         /\ seq' = seq

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 
    
=============================================================================
\* Modification History
\* Last modified Thu Feb 04 09:12:49 MST 2021 by jeremy
\* Created Thu Feb 04 08:57:52 MST 2021 by jeremy
