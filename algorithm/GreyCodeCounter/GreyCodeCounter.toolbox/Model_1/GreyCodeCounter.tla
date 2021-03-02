-------------------------- MODULE GreyCodeCounter --------------------------
EXTENDS Sequences, Integers, TLC

(* Grey Code is a way of encoding binary information such that no two bits flip in one step. 
 This is used in Flash Memory to minimize bit flips during self-discharge *)

(*--algorithm GreyCode {

variable flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>};
{

while (TRUE) { 
    if (flashCell = <<0, 0>>)
        flashCell := <<0,1>>
    else
        flashCell := <<1,1>>
       }
}
}
end algorithm;
*)


\* BEGIN TRANSLATION (chksum(pcal) = "161190de" /\ chksum(tla) = "a50aa7b8")
VARIABLE flashCell

vars == << flashCell >>

Init == (* Global variables *)
        /\ flashCell \in {<<0,0>>, <<0, 1>>, <<1,1>>, <<1,0>>}

Next == IF flashCell = <<0, 0>>
           THEN /\ flashCell' = <<0,1>>
           ELSE /\ flashCell' = <<1,1>>

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 


TypeOk == flashCell[1] \in {0, 1} /\ flashCell[2] \in {0,1} \* They are 1 indexed!


=============================================================================
\* Modification History
\* Last modified Tue Mar 02 16:26:41 MST 2021 by jeremy
\* Created Tue Mar 02 16:05:58 MST 2021 by jeremy
