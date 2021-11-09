-------------------------- MODULE SodaMachine --------------------------

EXTENDS Integers, Sequences,  TLC

VARIABLES IHaveSoda, sodaMachine, IWantSoda, Money

vars == <<IHaveSoda, IWantSoda, sodaMachine, Money>>

Init == 
    /\ IHaveSoda = FALSE
    /\ IWantSoda = TRUE
    /\ sodaMachine = 5
    /\ Money \in 1..8
    
    
SodaMachineHasSoda == sodaMachine > 0
IHaveMoney == Money > 0

PutMoneyInMachine == 
    \/ SodaMachineHasSoda /\ IHaveMoney
        /\ Money' = Money - 1
        /\ IHaveSoda' = TRUE
        /\ sodaMachine' = sodaMachine - 1
        /\ IWantSoda' = FALSE
    \/ ~SodaMachineHasSoda
        /\ UNCHANGED <<Money, IHaveSoda, sodaMachine, IWantSoda>>

Next == 
    \/ IHaveSoda
        /\ IHaveSoda' = FALSE
        /\ IWantSoda' = TRUE
        /\ UNCHANGED <<Money, sodaMachine>>
    \/ SodaMachineHasSoda /\ IWantSoda
        /\ PutMoneyInMachine
    \/ SodaMachineHasSoda /\ ~IWantSoda
        /\ UNCHANGED vars
    \/ ~SodaMachineHasSoda
        /\ UNCHANGED vars
   

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)

TypeOK == 
    /\ Money >= 0
    /\ sodaMachine >= 0
    /\ IWantSoda \in {TRUE, FALSE}
    /\ IHaveSoda \in {TRUE, FALSE}
   
IEventuallyGetSoda == IHaveMoney => <>IHaveSoda
INeverGetSoda == IHaveSoda = FALSE


=============================================================================
\* Modification History
\* Last modified Tue Nov 09 11:50:44 MST 2021 by jeremy
\* Created Tue Nov 02 18:15:25 MST 2021 by jeremy


