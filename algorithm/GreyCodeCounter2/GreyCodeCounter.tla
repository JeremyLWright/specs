-------------------------- MODULE GreyCodeCounter --------------------------
EXTENDS Sequences, Integers, TLC

(* Grey Code is a way of encoding binary information such that no two bits flip in one step. 
 This is used in Flash Memory to minimize bit flips during self-discharge *)

VARIABLES flashCell, pc

vars == << flashCell, pc >>

Init == (* Global variables *)
        /\ flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>}
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF flashCell = <<0, 0>>
               THEN /\ flashCell' = <<0,1>>
                    /\ pc' = "Lbl_2"
               ELSE /\ IF flashCell = <<0, 1>>
                          THEN /\ flashCell' = <<1,1>>
                               /\ pc' = "Lbl_3"
                          ELSE /\ IF flashCell = <<1, 0>>
                                     THEN /\ flashCell' = <<0,0>>
                                          /\ pc' = "Lbl_4"
                                     ELSE /\ flashCell' = <<1,0>>
                                          /\ pc' = "Lbl_5"

Lbl_2 == /\ pc = "Lbl_2"
         /\ pc' = "Lbl_1"
         /\ UNCHANGED flashCell

Lbl_3 == /\ pc = "Lbl_3"
         /\ pc' = "Lbl_1"
         /\ UNCHANGED flashCell

Lbl_4 == /\ pc = "Lbl_4"
         /\ pc' = "Lbl_1"
         /\ UNCHANGED flashCell

Lbl_5 == /\ pc = "Lbl_5"
         /\ pc' = "Lbl_1"
         /\ UNCHANGED flashCell

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4 \/ Lbl_5

Spec == Init /\ [][Next]_vars


TypeOk == flashCell[1] \in {0, 1} /\ flashCell[2] \in {0,1} \* They are 1 indexed!

(*
Only 1 bit can change between two states. <<0,0>> -> <<1,1>> is an illegal transition.
Hence, "distance" between any two states is | {0, 1} |
*)

=============================================================================
\* Modification History
\* Last modified Tue Mar 09 20:50:45 MST 2021 by jerem
\* Last modified Tue Mar 02 18:33:42 MST 2021 by jeremy
\* Created Tue Mar 02 16:05:58 MST 2021 by jeremy
