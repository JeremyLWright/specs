---- MODULE sandwich ----

EXTENDS Integers, Sequences, TLC

(***********************************************************************************)
(* inspired by *)
(* https://github.com/jameshfisher/tlaplus/blob/master/examples/DieHard/DieHard.tla *)

(***************************************************************************)
(* jam starts in fridge, *)
(* peanut butter (pb) in pantry, and bread is on table. *)
(* To construct the sandwich, gather all items on the table. *)
(* After sandwich is made, return items to their original location. *)

VARIABLES jam_location,
pb_location,
bread_location, sandwiches

vars == <<jam_location,pb_location,bread_location, sandwiches>>

(***************************************************************************)
(* valid locations for each of the *)
(* three items to be *)

TypeOk == 
    /\ jam_location \in {"fridge", "table"}
    /\ pb_location \in {"pantry", "table"}
    /\ bread_location \in {"table"}
    /\ sandwiches \in Nat

(***************************************************************************)
(* Define of the initial predicate -- *)
(* specifies the initial values of the variables. *)

Init == 
    /\ jam_location = "fridge"
    /\ pb_location = "pantry"
    /\ bread_location = "table"
    /\ sandwiches = 0
    

EveryPutAway == 
    /\ jam_location = "fridge"
    /\ pb_location = "pantry"
    /\ bread_location = "table"
    /\ UNCHANGED sandwiches

(***************************************************************************)
(* Define the actions *)

MoveJamToTable == /\ jam_location' = "table"
    /\ UNCHANGED <<pb_location, bread_location, sandwiches>>


MoveJamToFridge == /\ jam_location' = "fridge"
    /\ UNCHANGED <<pb_location, bread_location, sandwiches>>

MovePbToTable == /\ pb_location' = "table"
    /\ UNCHANGED <<jam_location, bread_location, sandwiches>>

MovePbToPantry == /\ pb_location' = "pantry"
    /\ UNCHANGED <<jam_location, bread_location, sandwiches>>
(***************************************************************************)
(* Define the next-state relation *)

Next == 
    \/ MoveJamToTable
    \/ MoveJamToFridge
    \/ MovePbToTable
    \/ MovePbToPantry

(***************************************************************************)
(* Define the formula Spec to be the complete specification, asserting *)
(* of a behavior that it begins in a state satisfying Init, and that every *)
(* step either satisfies Next or else leaves the set of locations unchanged *)

Spec == Init /\ [][Next]_vars /\ WF_vars(Next) 

(***************************************************************************)
(* Successful sandwich will be completed when two conditions are met *)
(* 1) <<jam,pb,bread>> are all on table, *)
(* and then, sometime later *)
(* 2) <<jam,pb,bread>> are back to their initial locations. *)

MakeSandwich == /\ jam_location = "table"
/\ pb_location = "table"
/\ bread_location = "table"
/\ sandwiches' = sandwiches + 1

(* I'm not clear how to express the terminating condition. *)
(* https://learntla.com/core/temporal-logic.html#eventually-diamond *)
(* https://learntla.com/core/temporal-logic.html#id2 *)



Done == [](jam_location = "fridge" => <>(sandwiches > 0)) \* Always, when jam is in the fridge, then eventually I have a sandwich
(* Done == MakeSandwich ~> Init *)

=======

\* Modification History
\* Last modified Tue Dec 06 13:54:50 MST 2022 by jeremy
\* Created Tue Dec 06 13:42:08 MST 2022 by jeremy
