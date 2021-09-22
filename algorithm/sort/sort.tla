---- MODULE sort ----

EXTENDS Sequences, Integers, TLC

CONSTANTS N 
ASSUME NonEmptyArray == N \in Nat /\ N >= 1


(*--fair algorithm BubbleSort {
    variables A \in [1..N -> Int], A0 = A, i = 1, j = 1, totalSteps = 0;
    { while (i < N) {
        j := i + 1;
        while (j > 1 /\ A[j - 1] > A[j]) {
            A[j-1] := A[j] || A[j] := A[j - 1];
            j := j - 1;
            totalSteps := totalSteps + 1;
        };
        i := i + 1;
        totalSteps := totalSteps + 1;
    };
    }
}
*)
\* BEGIN TRANSLATION (chksum(pcal) = "7c28162a" /\ chksum(tla) = "1ca5e7c3")
VARIABLES A, A0, i, j, totalSteps, pc

vars == << A, A0, i, j, totalSteps, pc >>

Init == (* Global variables *)
        /\ A \in [1..N -> Int]
        /\ A0 = A
        /\ i = 1
        /\ j = 1
        /\ totalSteps = 0
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF i < N
               THEN /\ j' = i + 1
                    /\ pc' = "Lbl_2"
               ELSE /\ pc' = "Done"
                    /\ j' = j
         /\ UNCHANGED << A, A0, i, totalSteps >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF j > 1 /\ A[j - 1] > A[j]
               THEN /\ A' = [A EXCEPT ![j-1] = A[j],
                                      ![j] = A[j - 1]]
                    /\ j' = j - 1
                    /\ totalSteps' = totalSteps + 1
                    /\ pc' = "Lbl_2"
                    /\ i' = i
               ELSE /\ i' = i + 1
                    /\ totalSteps' = totalSteps + 1
                    /\ pc' = "Lbl_1"
                    /\ UNCHANGED << A, j >>
         /\ A0' = A0

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 

TypeOK == /\ i \in 1..N
          /\ j \in 1..N
          /\ A \in [1..N -> Int]
          /\ A0 \in [1..N -> Int]
          /\ pc \in {"Lbl_1", "Lbl_2", "Done"}

IsSorted == \A a \in 1..N: 
                \A b \in a..N:
                    A[a] <= A[b]

ComputationalComplexity == totalSteps <= N * N

IsSortedAlex == \A a,b \in 1..N: a < b => A[a] <= A[b]



EventuallySorted == pc="Done" => IsSortedAlex

\* "Material Conditional"
            
==== 
