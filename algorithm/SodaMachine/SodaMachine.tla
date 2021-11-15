------------------------- MODULE SodaMachinePublish -------------------------

EXTENDS Integers, Sequences, TLC

VARIABLES IHaveSoda, sodaMachine, IWantSoda, Money

vars == <<IHaveSoda, sodaMachine, IWantSoda, Money>>


IHaveMoney == Money > 0 
SodaMachineHasSoda == sodaMachine > 0


PutMoneyInMachine ==
    \/ SodaMachineHasSoda
        /\ Money' = Money - 1
        /\ IHaveSoda' = TRUE
        /\ sodaMachine' = sodaMachine - 1
        /\ IWantSoda' = FALSE
    \/ ~SodaMachineHasSoda
        /\ UNCHANGED vars


Init == 
    /\ IHaveSoda = FALSE
    /\ IWantSoda = TRUE
    /\ sodaMachine \in 4..7
    /\ Money \in 2..10

Next == 
    \/ IHaveSoda
        /\ IHaveSoda' = FALSE
        /\ IWantSoda' = TRUE
        /\ UNCHANGED <<Money, sodaMachine>>
    \/ IWantSoda /\ IHaveMoney
        /\ PutMoneyInMachine
    \/ 
        /\ ~IWantSoda \/ ~SodaMachineHasSoda
        /\ UNCHANGED vars

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)


TypeInvariant ==
    /\ Money >= 0
    /\ sodaMachine >= 0
    /\ IWantSoda \in {TRUE, FALSE}
    /\ IHaveSoda \in {TRUE, FALSE}
    
   

IEventuallyGetSoda == [](IHaveMoney /\ SodaMachineHasSoda => <>IHaveSoda) \* Always, I Have Money implies eventually I Have Soda

=============================================================================
\* Modification History
\* Last modified Sun Nov 14 16:14:08 MST 2021 by jeremy
\* Created Sun Nov 14 15:37:46 MST 2021 by jeremy
