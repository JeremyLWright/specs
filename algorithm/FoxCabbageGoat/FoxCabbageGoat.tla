--------------------------- MODULE FoxCabbageGoat ---------------------------
EXTENDS Sequences, Integers, TLC

(* Fox Cabbage & Goat describes a farmer trying to move his assets from 1 side of the river to the other.
- Fox cannot be alone with the Goat.
- Goat cannot be alone with the cabbage.
 *)

VARIABLES eastBank, westBank

Init == (* Global variables *)
        /\ eastBank \in {<<"Fox", "Cabbage", "Goat">>}
        /\ westBank \in {<<>>}


Next == 
        \/ FoxSailWest => "Fox" \in westBank
        \/ FoxSailEast
        \/ GoatSailWest
        \/ GoatSailEast
        \/ CabbageSailEast
        \/ CabbageSailWest
        
        
\* Fox cannot be alone with goat
FoxSailWest == "Goat" \in westBank => FALSE \* If Goat is on west bank, then we cannot sail to west bank
\* This definition doesn't work. We have to model the boat. What can get in the boat. ExchangewithBoat etc


FoxSailEast == FALSE
GoatSailWest == FALSE
GoatSailEast == FALSE
CabbageSailEast == FALSE
CabbageSailWest == FALSE
        
        
=============================================================================
\* Modification History
\* Last modified Wed Mar 10 22:45:59 MST 2021 by jerem
\* Created Tue Mar 09 20:55:50 MST 2021 by jerem
