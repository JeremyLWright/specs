------------------------------ MODULE Modulus3 ------------------------------


EXTENDS Naturals

CONSTANT Z

VARIABLE Register

vars == <<Register>>

Add1 == IF Register \in {1, Z} THEN UNCHANGED Register ELSE Register' = Register + 1

Add0 == UNCHANGED Register

AddZ == IF Register = Z THEN UNCHANGED Register ELSE Register' = Z



Morphisms == 
    \/ Add1
    \/ Add0
    \/ AddZ


Init == \E v \in {0, 1, Z} : 
            Register = v



Spec == Init /\ [][Morphisms]_vars /\ WF_vars(Morphisms)


TypeOK == 
    /\ Register \in {0, 1, Z}

=============================================================================
\* Modification History
\* Last modified Fri Aug 12 14:59:57 MST 2022 by jeremy
\* Created Fri Aug 12 14:39:31 MST 2022 by jeremy
