------------------------------- MODULE Euclid -------------------------------

EXTENDS Integers, GCD, TLC

CONSTANTS M,N

ASSUME /\ M \in Nat \ {0}
       /\ N \in Nat \ {0}
       
(****************************************************
--fair algorithm Euclid {

variables x \in 1..N, y \in 1..N, x0 = x, y0=y;
{ 
  while(x /= y) {
    if (x < y) { y := y - x}
    else {x := x - y}
  }; assert (x = y) /\ x = GCD(x0, y0)
}
}
*****************************************************)
\* BEGIN TRANSLATION (chksum(pcal) = "e44a3caf" /\ chksum(tla) = "fa860b26")
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
               ELSE /\ Assert((x = y) /\ x = GCD(x0, y0), 
                              "Failure of assertion at line 18, column 6.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << x, y >>
         /\ UNCHANGED << x0, y0 >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 

PartialCorrectness == (pc = "Done") => (x = y) /\ x = GCD(x0, y0)
=============================================================================
\* Modification History
\* Last modified Thu Mar 11 17:00:31 MST 2021 by jerem
\* Created Wed Mar 10 23:08:35 MST 2021 by jerem
