------------------------- MODULE SodaMachinePublish -------------------------

EXTENDS Integers, Sequences, TLC

VARIABLES IHaveSoda, sodaMachine, IWantSoda, Money

vars == <<IHaveSoda, sodaMachine, IWantSoda, Money>>


IHaveMoney == Money > 0 
SodaMachineHasSoda == sodaMachine > 0


PutMoneyInMachine ==
    /\ IWantSoda
    /\ IHaveMoney
    /\ SodaMachineHasSoda
        /\ Money' = Money - 1
        /\ IHaveSoda' = TRUE
        /\ sodaMachine' = sodaMachine - 1
        /\ IWantSoda' = FALSE


DrinkSoda == 
    /\ IHaveSoda
    /\ IHaveSoda' = FALSE
    /\ IWantSoda' = TRUE
    /\ UNCHANGED <<Money, sodaMachine>>
    
NothingHappens == 
    /\ Money = 0 \/ sodaMachine = 0 
    /\ UNCHANGED vars


Init == 
    /\ IHaveSoda = FALSE
    /\ IWantSoda = TRUE
    /\ sodaMachine \in 4..7
    /\ Money \in 2..10

Next ==
    \/ DrinkSoda
    \/ PutMoneyInMachine
    \/ NothingHappens
    

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)


TypeInvariant ==
    /\ Money >= 0
    /\ sodaMachine >= 0
    /\ IWantSoda \in {TRUE, FALSE}
    /\ IHaveSoda \in {TRUE, FALSE}
    
   

IEventuallyGetSoda == [](IHaveMoney /\ SodaMachineHasSoda => <>IHaveSoda) \* Always, I Have Money implies eventually I Have Soda

=============================================================================
\* Modification History
\* Last modified Fri Dec 17 13:09:21 MST 2021 by jeremy
\* Created Sun Nov 14 15:37:46 MST 2021 by jeremy
