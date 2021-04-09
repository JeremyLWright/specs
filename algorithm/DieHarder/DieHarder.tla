------------------------------ MODULE DieHarder ------------------------------

EXTENDS Integers, Naturals, GCD

CONSTANTS Goal, Jugs, Capacity

GoalFitsInSingleJug == \E j \in Jugs : Capacity[j] > Goal 
\* SetMax({Capacity[j] : j \in Jugs}) < Goal

ASSUME  /\ Goal \in Nat
        /\ Capacity \in [Jugs -> Nat \ {0}]
        /\ GoalFitsInSingleJug


Min(m, n) == IF m < n THEN m ELSE n
Max(m, n) == IF m > n THEN m ELSE n

(*--algorithm DieHarder 
    variable inJug = [j \in Jugs |-> 0];
    begin
    while(TRUE) do
        either with j \in Jugs do
                inJug[j] := Capacity[j]
            end with;
        or with j \in Jugs do
                inJug[j] := 0
            end with;
        or with j \in Jugs, k \in Jugs \ {j} do
            with poured = Min(inJug[j]+inJug[k], Capacity[k]) - inJug[k] do
                inJug[j] := inJug[j] - poured || inJug[k] := inJug[k] + poured;
            end with;
        end with;
        end either;
    end while;


end algorithm; *)

\* BEGIN TRANSLATION (chksum(pcal) = "80f9488d" /\ chksum(tla) = "af3f8e5b")
VARIABLES inJug, pc

vars == << inJug, pc >>

Init == (* Global variables *)
        /\ inJug = [j \in Jugs |-> 0]
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ \/ /\ \E j \in Jugs:
                    inJug' = [inJug EXCEPT ![j] = Capacity[j]]
            \/ /\ \E j \in Jugs:
                    inJug' = [inJug EXCEPT ![j] = 0]
            \/ /\ \E j \in Jugs:
                    \E k \in Jugs \ {j}:
                      LET poured == Min(inJug[j]+inJug[k], Capacity[k]) - inJug[k] IN
                        inJug' = [inJug EXCEPT ![j] = inJug[j] - poured,
                                               ![k] = inJug[k] + poured]
         /\ pc' = "Lbl_1"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

DefuseBomb == \A j \in Jugs : inJug[j] /= Goal \* Look for a violation which is the solution....


SolutionExists == Divides(SetGCD({Capacity[j] : j \in Jugs}), Goal)

=============================================================================
\* Modification History
\* Last modified Thu Mar 04 09:33:26 MST 2021 by jeremy
\* Created Wed Mar 03 16:20:33 MST 2021 by jeremy
