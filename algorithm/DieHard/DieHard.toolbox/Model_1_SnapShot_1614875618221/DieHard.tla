------------------------------ MODULE DieHard ------------------------------

EXTENDS Integers

VARIABLES bigJug, smallJug


TypeOk == /\ smallJug \in 0..3
          /\ bigJug \in 0..5

Init == /\ bigJug = 0
        /\ smallJug = 0
        
 

Min(m,n) == IF m < n THEN m ELSE n

        

FillSmallJug == /\ smallJug' = 3
             /\ bigJug' = bigJug

FillBigJug == /\ bigJug' = 5
              /\ smallJug' = smallJug

EmptySmallJug == /\ smallJug' = 0
                 /\ bigJug' = bigJug

EmptyBigJug == /\ smallJug' = smallJug
                 /\ bigJug' = 0

SmallToBig == 
LET 
    pouredAmount == Min(bigJug + smallJug, 5) - bigJug
IN 
    /\ bigJug' = bigJug + pouredAmount
    /\ smallJug' = smallJug - pouredAmount
    
BigToSmall ==
LET 
    pouredAmount == Min(bigJug+smallJug, 3) - smallJug
IN
    /\ bigJug' = bigJug - pouredAmount
    /\ smallJug' = smallJug + pouredAmount
              
Next == \/ FillSmallJug
        \/ FillBigJug
        \/ EmptySmallJug
        \/ EmptyBigJug
        \/ SmallToBig
        \/ BigToSmall
        
DefuseBomb == bigJug /= 4 \* Look for a violation which is the solution....

          
          
          
          
        

=============================================================================
\* Modification History
\* Last modified Thu Mar 04 09:33:26 MST 2021 by jeremy
\* Created Wed Mar 03 16:20:33 MST 2021 by jeremy
