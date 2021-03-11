--------------------------- MODULE OneBitPlusCal ---------------------------

(*--algorithm Clock {

variable b \in {0, 1};
{

while (TRUE) { 
    if (b = 0) 
        b := 1 
    else 
        b := 0 
}
}
}
end algorithm;
*)
\* BEGIN TRANSLATION (chksum(pcal) = "aeec3606" /\ chksum(tla) = "755a7ff9")
VARIABLE b

vars == << b >>

Init == (* Global variables *)
        /\ b \in {0, 1}

Next == IF b = 0
           THEN /\ b' = 1
           ELSE /\ b' = 0

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 




TypeOk == b \in {0, 1}
=============================================================================
\* Modification History
\* Last modified Tue Mar 02 16:02:56 MST 2021 by jeremy
\* Created Tue Mar 02 15:52:25 MST 2021 by jeremy
