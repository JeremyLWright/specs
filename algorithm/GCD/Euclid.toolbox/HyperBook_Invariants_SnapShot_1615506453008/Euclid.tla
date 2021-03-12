------------------------------- MODULE Euclid -------------------------------

EXTENDS Integers, GCD

CONSTANTS M,N

ASSUME /\ M \in Nat \ {0}
       /\ N \in Nat \ {0}
       
(****************************************************
--algorithm Euclid {

variables x = 1..M, y = 1..N;
{ 
  while(x /= y) {
    if (x < y) { y := y - x}
    else {x := x - y}
  }
}
}
*****************************************************)
\* BEGIN TRANSLATION (chksum(pcal) = "b74d51fc" /\ chksum(tla) = "c184363e")
VARIABLES x, y, pc

vars == << x, y, pc >>

Init == (* Global variables *)
        /\ x = 1..M
        /\ y = 1..N
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF x /= y
               THEN /\ IF x < y
                          THEN /\ y' = y - x
                               /\ x' = x
                          ELSE /\ x' = x - y
                               /\ y' = y
                    /\ pc' = "Lbl_1"
               ELSE /\ pc' = "Done"
                    /\ UNCHANGED << x, y >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

PartialCorrectness == (pc = "Done") => (x = y) /\ x = GCD(M, N)
=============================================================================
\* Modification History
\* Last modified Thu Mar 11 16:47:22 MST 2021 by jerem
\* Created Wed Mar 10 23:08:35 MST 2021 by jerem
