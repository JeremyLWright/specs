------------------------- MODULE WhatsForLunch -------------------------

EXTENDS Integers, Sequences, SequencesExt, TLC

VARIABLES ProposerStates, AcceptorState, ProposalQueue, LunchPlaces

CONSTANT NULL
CONSTANT PendingProposal

vars == <<ProposerStates, ProposalQueue, LunchPlaces, AcceptorState>>

\* Acceptor pulls events from a queue
\* Acceptor accepts the first event it sees
\* once a value is accepted, it replies to all proposals 
\* with the accepted value


\* Proposer propose a value from their desired places to eat. 
\* as long as i haven't heard from the acceptor, i could make a different proposal
IHaventConfirmedPlaceForLunch(id) == ProposerStates[id] = NULL

Propose(id) == 
    \/ IHaventConfirmedPlaceForLunch(id) 
        /\ \E lunchPlace \in LunchPlaces : 
            /\ ProposalQueue' = Append(ProposalQueue, [address |-> id, proposal |-> lunchPlace ])
            \* /\ ProposerStates' = [ProposerStates EXCEPT ![id] = PendingProposal] \* Seems dangerous... I don't know my value is committed
        /\ UNCHANGED <<AcceptorState, LunchPlaces>>
    \/ UNCHANGED <<AcceptorState, LunchPlaces, ProposerStates, ProposalQueue>>

\* If we've decided a value, respond to all future proposals with the value. 
Acceptor == 
    \/ Len(ProposalQueue) > 0 /\ AcceptorState = NULL 
            /\ LET msg == Head(ProposalQueue) IN
                /\ AcceptorState' = msg.proposal
                \* This doesn't work you cannot update part of a state /\ ProposerStates[msg.address]' = msg.proposal
                /\ ProposerStates' = [ProposerStates EXCEPT ![msg.address] = msg.proposal]
                /\ ProposalQueue' = Tail(ProposalQueue)
                /\ UNCHANGED <<LunchPlaces>>
    \/ Len(ProposalQueue) > 0 /\ AcceptorState /= NULL
        /\ LET msg == Head(ProposalQueue) IN
            /\ ProposerStates' = [ProposerStates EXCEPT ![msg.address] = AcceptorState]
            /\ ProposalQueue' = Tail(ProposalQueue)
        /\ UNCHANGED <<AcceptorState, LunchPlaces>>
    \/ UNCHANGED vars




Init == 
    /\ AcceptorState = NULL
    /\ ProposerStates = <<NULL, NULL, NULL>>
    /\ ProposalQueue = <<>>
    /\ LunchPlaces = {"Falafel", "Hamburgers"}

Next == 
    \/ \E proposer \in DOMAIN ProposerStates : Propose(proposer)
    \/ Acceptor

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)


TypeOk ==
    /\ AcceptorState = NULL 
        \/ AcceptorState \in LunchPlaces
\*TypeInvariant ==
\*    /\ Money >= 0
\*    /\ sodaMachine >= 0
\*    /\ IWantSoda \in {TRUE, FALSE}
\*    /\ IHaveSoda \in {TRUE, FALSE}
    
   
\* cannot guarantee that not all proposers will propose 
EventuallyConsensus == <>[](\A proposal \in DOMAIN ProposerStates: 
    ProposerStates[proposal] = AcceptorState)

EventuallyAllProposersLearnTheSameValue == 
    <>[](\E proposer \in DOMAIN ProposerStates: 
        IF ProposerStates[proposer] /= NULL 
        THEN ProposerStates[proposer] = AcceptorState 
        ELSE ProposerStates[proposer] = PendingProposal)

=============================================================================
