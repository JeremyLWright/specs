---- MODULE quicksort ----

EXTENDS Integers, TLC, Sequences, SequencesExt, FiniteSets, Naturals

CONSTANTS N
ASSUME N \in Nat

(*--fair algorithm QuickSort {


procedure partition(A, low, high)
    variables pivot = A[high];
     {
         skip;
};


    variables A \in [1..N -> Int], A0 = A, low = 1, high = Len(A);{
    {
        if(low < high) {
            partition

        };
    }
    }


}*)
\* BEGIN TRANSLATION (chksum(pcal) = "7c28162a" /\ chksum(tla) = "bd63dfe5")
VARIABLES A, A0, low, high, pc

vars == << A, A0, low, high, pc >>

Init == (* Global variables *)
        /\ A \in [1..N -> Int]
        /\ A0 = A
        /\ low = 1
        /\ high = Len(A)
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF low < high
               THEN /\ TRUE
               ELSE /\ TRUE
         /\ pc' = "Done"
         /\ UNCHANGED << A, A0, low, high >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 

==== 
