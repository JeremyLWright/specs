------------------------- MODULE WhatsForLunch -------------------------

(* 
 What's For lunch is a simple concensus algorithm. The premise is a driver and some number
 of passengers are in a car driving to Lunch. A passenger shouts out a destination for lunch. The Driver 
 accepts the first suggestion. All future proposals are ignored, and the driver responds with the 
 initial decision.

 Consensus is defined as all passengers holding the same destination as the driver, the acceptor. 
*)



EXTENDS Integers, Sequences, SequencesExt, TLC

VARIABLES ProposerStates, AcceptorState, AcceptorQueue, ProposerQueues

CONSTANT NULL
CONSTANT LunchPlaces

vars == <<ProposerStates, AcceptorQueue, AcceptorState, ProposerQueues>>

\* Acceptor pulls events from a queue
\* Acceptor accepts the first event it sees
\* once a value is accepted, it replies to all proposals 
\* with the accepted value

Propose == 
    \E id \in DOMAIN ProposerStates : 
        \/ Len(ProposerQueues[id]) > 0 /\ ProposerStates[id] = NULL
                /\ LET msg == Head(ProposerQueues[id]) IN
                    /\ ProposerQueues' = [ProposerQueues EXCEPT ![id] = Tail(ProposerQueues[id])]
                    /\ ProposerStates' = [ProposerStates EXCEPT ![id] = msg]
                    /\ UNCHANGED <<AcceptorState, AcceptorQueue>>
        \/ Len(ProposerQueues[id]) > 0 /\ ProposerStates[id] /= NULL 
                \* If I already heard where we're going, then ignore any new value. 
                /\ ProposerQueues' = [ProposerQueues EXCEPT ![id] = Tail(ProposerQueues[id])]
                /\ UNCHANGED <<AcceptorState, ProposerStates, AcceptorQueue>>
        \/ Len(ProposerQueues[id]) = 0 /\ ProposerStates[id] = NULL /\ Len(AcceptorQueue) < 3
            /\ \E lunchPlace \in LunchPlaces : 
                /\ AcceptorQueue' = Append(AcceptorQueue, [address |-> id, proposal |-> lunchPlace ])
            /\ UNCHANGED <<AcceptorState, ProposerStates, ProposerQueues>>
        \/ Len(ProposerQueues[id]) = 0 /\ ProposerStates[id] /= NULL 
            /\ UNCHANGED vars

\* If we've decided a value, respond to all future proposals with the value. 
AcceptFirstProposal == 
    Len(AcceptorQueue) > 0 /\ AcceptorState = NULL 
        /\ LET msg == Head(AcceptorQueue) IN
            /\ AcceptorState' = msg.proposal
            /\ ProposerQueues' = [ProposerQueues EXCEPT ![msg.address] = Append(ProposerQueues[msg.address], msg.proposal) ]
            /\ AcceptorQueue' = Tail(AcceptorQueue)
            /\ UNCHANGED <<ProposerStates>>

ReplyWithAcceptedValue ==
    Len(AcceptorQueue) > 0 /\ AcceptorState /= NULL
        /\ LET msg == Head(AcceptorQueue) IN
            /\ ProposerQueues' = [ProposerQueues EXCEPT ![msg.address] = Append(ProposerQueues[msg.address], AcceptorState)]
            /\ AcceptorQueue' = Tail(AcceptorQueue)
            /\ UNCHANGED <<AcceptorState, ProposerStates>>

Acceptor == 
    \/ AcceptFirstProposal 
    \/ ReplyWithAcceptedValue
    \/ Len(AcceptorQueue) = 0 
        /\ UNCHANGED vars

Init == 
    /\ AcceptorState = NULL
    /\ ProposerStates = <<NULL, NULL>>
    /\ AcceptorQueue = <<>>
    /\ ProposerQueues = << <<>>, <<>> >>

Next == 
    \/ Propose 
    \/ Acceptor

Spec == Init /\ [][Next]_vars /\ WF_vars(Next) \* /\ SF_vars(Propose)


Range(f) == {f[x] : x \in DOMAIN f}

TypeOk ==
    /\ AcceptorState \in {NULL} \union LunchPlaces
    /\ Range(ProposerStates) \subseteq {NULL} \union LunchPlaces

QueuesAreTooBig == 
    /\ Len(ProposerQueues[1]) < 10
    /\ Len(ProposerQueues[2]) < 10


OnceAcceptedEventuallyEveryoneAgrees == AcceptorState /= NULL => <>[](Range(ProposerStates) = {AcceptorState})

EventuallyAcceptorDecides == <>[](AcceptorState /= NULL)


============================================================================
