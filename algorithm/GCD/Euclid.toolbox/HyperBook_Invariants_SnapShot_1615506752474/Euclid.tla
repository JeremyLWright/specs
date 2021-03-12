------------------------------- MODULE Euclid -------------------------------

EXTENDS Integers, GCD

CONSTANTS M,N

ASSUME /\ M \in Nat \ {0}
       /\ N \in Nat \ {0}
       
(****************************************************
--algorithm Euclid {

variables x \in 1..N, y \in 1..N, x0 = x, y0=y;
{ 
  while(x /= y) {
    if (x < y) { y := y - x}
    else {x := x - y}
  }
}
}
*****************************************************)
\* BEGIN TRANSLATION (chksum(pcal) = "11f5e744" /\ chksum(tla) = "e97c1ce4")
VARIABLES x, y, x0, y0, pc

vars == << x, y, x0, y0, pc >>

Init == (* Global variables *)
        /\ x \in 1..N
        /\ y \in 1..N
        /\ x0 = x
        /\ y0 = y
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
         /\ UNCHANGED << x0, y0 >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

PartialCorrectness == (pc = "Done") => (x = y) /\ x = GCD(x0, y0)
=============================================================================
\* Modification History
\* Last modified Thu Mar 11 16:52:22 MST 2021 by jerem
\* Created Wed Mar 10 23:08:35 MST 2021 by jerem
