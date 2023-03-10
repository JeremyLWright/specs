---------------------------- MODULE RingElection ----------------------------

EXTENDS TLC, FiniteSets, Sequences, Integers, Functions, Naturals

CONSTANTS participants

ASSUME Cardinality(participants) > 1 \* A leader in a single node system is tauntological

VARIABLES outboxes, processes, successors, winner
    

vars == <<outboxes, processes, successors, winner>>

atoi(str) == CHOOSE i \in Int : ToString(i) = str

Init == 
    /\ successors = {<<"p1", "p2">>, <<"p2", "p3">>, <<"p3", "p1">>}
    /\ outboxes = [participant \in participants |-> {}]
    /\ processes = participants
    /\ winner = {}
    
\* GreaterThanMe(self, other) == 
\*    IF self

Id(process) == atoi(Tail(process))

SendMessage(p, m) == outboxes' = [outboxes EXCEPT ![p] = outboxes[p] \union {m}]

SendMessages == \* Arbitrarily place a message in your outbox
    \E process \in participants : 
       /\ SendMessage(process, process)
       /\ UNCHANGED <<processes, successors, winner>>
       
\* fetch p's message
RecieveMessage(self) == 
    LET process == CHOOSE pair \in successors : pair[2] = self
        outbox == process[1]
    IN \E msg \in outboxes[outbox] :
        /\ outboxes' = [outboxes EXCEPT ![outbox] = outboxes[outbox] \ {msg}]
        /\ IF Id(msg) > Id(self) 
           THEN SendMessage(self, msg)
           ELSE IF msg = self THEN winner = msg
           ELSE UNCHANGED winner
        
    

ReceiveMessages == \* Arbitrarily allow a node to accept a message from it's successor's outbox
    \E process \in participants :
        /\ RecieveMessage(process)
        /\ UNCHANGED <<processes, successors>>
    


Next == 
    \/ SendMessages
    \/ ReceiveMessages
    \/ UNCHANGED vars

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)

TypeOK == 
    /\ Cardinality(DOMAIN outboxes) = Cardinality(participants)
    /\ Cardinality(successors) = Cardinality(participants)
    /\ \A segment \in successors : Len(segment) = 2
    
GreatestId == CHOOSE x \in participants : 
                \A y \in participants : Id(x) > Id(y)
    
LeaderIsElected == <>[](winner = GreatestId)


=============================================================================
\* Modification History
\* Last modified Mon Jan 24 13:47:09 MST 2022 by jeremy
\* Created Mon Jan 24 11:49:33 MST 2022 by jeremy

