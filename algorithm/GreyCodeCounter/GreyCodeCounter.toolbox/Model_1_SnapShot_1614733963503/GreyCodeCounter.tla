-------------------------- MODULE GreyCodeCounter --------------------------
EXTENDS Sequences, Integers, TLC

(* Grey Code is a way of encoding binary information such that no two bits flip in one step. 
 This is used in Flash Memory to minimize bit flips during self-discharge *)

(*--algorithm GreyCode {

variables
    flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>};
    actions = [before |-> <<>>, after |-> <<>>];
{

while (TRUE) { 

    if (flashCell = <<0, 0>>) {
        actions.before := flashCell;
        flashCell := <<1,1>>;
        actions.after := flashCell;
    }
    else
    actions.before := flashCell;
        flashCell := <<1,1>>;
        actions.after := flashCell;
       }
}
}
end algorithm;
*)


\* BEGIN TRANSLATION (chksum(pcal) = "869dab23" /\ chksum(tla) = "dfe2da5e")
VARIABLES flashCell, actions, pc

vars == << flashCell, actions, pc >>

Init == (* Global variables *)
        /\ flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>}
        /\ actions = [before |-> <<>>, after |-> <<>>]
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF flashCell = <<0, 0>>
               THEN /\ actions' = [actions EXCEPT !.before = flashCell]
                    /\ flashCell' = <<1,1>>
                    /\ pc' = "Lbl_2"
               ELSE /\ actions' = [actions EXCEPT !.before = flashCell]
                    /\ pc' = "Lbl_3"
                    /\ UNCHANGED flashCell

Lbl_3 == /\ pc = "Lbl_3"
         /\ flashCell' = <<1,1>>
         /\ actions' = [actions EXCEPT !.after = flashCell']
         /\ pc' = "Lbl_1"

Lbl_2 == /\ pc = "Lbl_2"
         /\ actions' = [actions EXCEPT !.after = flashCell]
         /\ pc' = "Lbl_3"
         /\ UNCHANGED flashCell

Next == Lbl_1 \/ Lbl_3 \/ Lbl_2

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 


TypeOk == flashCell[1] \in {0, 1} /\ flashCell[2] \in {0,1} \* They are 1 indexed!

\* Only 1 bit can change between two states. <<0,0>> -> <<1,1>> is an illegal transition
OneBitAtATime == IF actions.before /= <<>> /\ actions.after /= <<>> 
    THEN
        (actions.after[1]+ actions.after[2]) - (actions.before[1] + actions.before[2]) \in {1}
    ELSE TRUE

=============================================================================
\* Modification History
\* Last modified Tue Mar 02 18:12:26 MST 2021 by jeremy
\* Created Tue Mar 02 16:05:58 MST 2021 by jeremy
