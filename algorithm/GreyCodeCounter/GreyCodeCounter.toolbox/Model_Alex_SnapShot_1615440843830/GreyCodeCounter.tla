-------------------------- MODULE GreyCodeCounter --------------------------
EXTENDS Sequences, Integers, TLC

(* Grey Code is a way of encoding binary information such that no two bits flip in one step. 
 This is used in Flash Memory to minimize bit flips during self-discharge *)

(*--algorithm GreyCode {

variables
    flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>};
{

while (TRUE) { 
    if (flashCell = <<0, 0>>) {
        flashCell := <<0,1>>;
    } else if (flashCell = <<0, 1>>) {
        flashCell := <<1,1>>;
    } else if (flashCell = <<1, 0>>) {
        flashCell := <<0,0>>;
    } else {
        flashCell := <<1,0>>;
    }
}
}
}
end algorithm;
*)


\* BEGIN TRANSLATION (chksum(pcal) = "41ab656b" /\ chksum(tla) = "8c1ba645")
VARIABLE flashCell

vars == << flashCell >>

Init == (* Global variables *)
        /\ flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>}

Next == IF flashCell = <<0, 0>>
           THEN /\ flashCell' = <<0,1>>
           ELSE /\ IF flashCell = <<0, 1>>
                      THEN /\ flashCell' = <<1,1>>
                      ELSE /\ IF flashCell = <<1, 0>>
                                 THEN /\ flashCell' = <<0,0>>
                                 ELSE /\ flashCell' = <<1,0>>

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 


TypeOk == flashCell[1] \in {0, 1} /\ flashCell[2] \in {0,1} \* They are 1 indexed!

(*
Only 1 bit can change between two states. <<0,0>> -> <<1,1>> is an illegal transition.
Hence, "distance" between any two states is | {0, 1} |

OneBitAtATime == IF actions.before /= <<>> /\ actions.after /= <<>> 
    THEN
         (actions.after[1] + actions.after[2]) - (actions.before[1] + actions.before[2])  \in {-1, 0, 1} 
    ELSE TRUE
*)


OneBitAtATime == (flashCell'[1] + flashCell'[2] - (flashCell[1] + flashCell[2])) \in {-1,0,1}

AlwaysOneBitAtATime == []([OneBitAtATime]_flashCell)
=============================================================================
\* Modification History
\* Last modified Wed Mar 10 22:32:43 MST 2021 by jerem
\* Last modified Fri Mar 05 10:26:11 MST 2021 by jeremy
\* Created Tue Mar 02 16:05:58 MST 2021 by jeremy
