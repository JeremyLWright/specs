------------------------------ MODULE leftpad ------------------------------
EXTENDS Sequences, Integers


PT == INSTANCE PT

Leftpad(c, n, str) ==
    LET
        outlength == PT!Max(Len(str), n)
        padlength == 
            CHOOSE padlength \in 0..n: 
                padlength + Len(str) = outlength
   IN
        [x \in 1..padlength |-> c] \o str
=============================================================================
\* Modification History
\* Last modified Fri Feb 05 11:44:11 MST 2021 by jeremy
\* Created Fri Feb 05 11:38:09 MST 2021 by jeremy
