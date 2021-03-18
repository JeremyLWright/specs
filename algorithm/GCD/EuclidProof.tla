------------------------------- MODULE EuclidProof -------------------------------

EXTENDS Integers, GCD, TLC

CONSTANTS M,N

ASSUME /\ M \in Nat \ {0}
       /\ N \in Nat \ {0}
       
(* --fair algorithm Euclid {

variables x = M, y = N;
{ 
  while(x /= y) {
    if (x < y) { y := y - x}
    else {x := x - y}
  }; assert (x = y) /\ x = GCD(M, N)
}
}

*)
\* BEGIN TRANSLATION (chksum(pcal) = "71e50359" /\ chksum(tla) = "17cbc59b")
VARIABLES x, y, pc

vars == << x, y, pc >>

Init == (* Global variables *)
        /\ x = M
        /\ y = N
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF x /= y
               THEN /\ IF x < y
                          THEN /\ y' = y - x
                               /\ x' = x
                          ELSE /\ x' = x - y
                               /\ y' = y
                    /\ pc' = "Lbl_1"
               ELSE /\ Assert((x = y) /\ x = GCD(M, N), 
                              "Failure of assertion at line 17, column 6.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << x, y >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 

PartialCorrectness == (pc = "Done") => (x = y) /\ x = GCD(M, N)
=============================================================================
\* Modification History
\* Last modified Thu Mar 11 17:00:31 MST 2021 by jerem
\* Created Wed Mar 10 23:08:35 MST 2021 by jerem
