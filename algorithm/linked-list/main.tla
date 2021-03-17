-------------------------------- MODULE main --------------------------------

EXTENDS TLC, Integers, FiniteSets, Sequences

CONSTANTS Nodes, NULL

INSTANCE linked_list WITH NULL <- NULL

AllLinkedLists == linked_list(Nodes)

CycleImpliesTwoParents(ll) ==
    Cyclic(ll) <=> 
        \E n \in DOMAIN ll:
            Cardinality({p \in DOMAIN ll: ll[p] = n}) = 2
            

CycleImpliesRingOrTwoParents(ll) ==
    Cyclic(ll) <=>
        \/ Ring(ll)
        \/ \E n \in DOMAIN ll:
            Cardinality({p \in DOMAIN ll: ll[p] = n}) = 2

 
Valid == 
 /\ \A ll \in AllLinkedLists:
    /\ Assert(CycleImpliesRingOrTwoParents(ll), <<"Counterexample: " , ll>>)


(*--fair algorithm tortise_and_hare
variables
    ll \in linked_list(Nodes),
    tortise = First(ll),
    hare = tortise;

macro advance(pointer) begin
    pointer := ll[pointer];
    if pointer = NULL then
        assert ~Cyclic(ll);
        goto Done;
    end if;
end macro;

begin 
    while TRUE do
        advance(tortise);
        advance(hare);
        advance(hare);
        
        if tortise = hare then
            assert Cyclic(ll);
            goto Done;
        end if
    end while
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-29d82f6240a42d4c97091a96c26c508e
VARIABLES ll, tortise, hare, pc

vars == << ll, tortise, hare, pc >>

Init == (* Global variables *)
        /\ ll \in linked_list(Nodes)
        /\ tortise = First(ll)
        /\ hare = tortise
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ tortise' = ll[tortise]
         /\ IF tortise' = NULL
               THEN /\ Assert(~Cyclic(ll), 
                              "Failure of assertion at line 38, column 9 of macro called at line 45, column 9.")
                    /\ pc' = "Done"
               ELSE /\ pc' = "Lbl_2"
         /\ UNCHANGED << ll, hare >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ hare' = ll[hare]
         /\ IF hare' = NULL
               THEN /\ Assert(~Cyclic(ll), 
                              "Failure of assertion at line 38, column 9 of macro called at line 46, column 9.")
                    /\ pc' = "Done"
               ELSE /\ pc' = "Lbl_3"
         /\ UNCHANGED << ll, tortise >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ hare' = ll[hare]
         /\ IF hare' = NULL
               THEN /\ Assert(~Cyclic(ll), 
                              "Failure of assertion at line 38, column 9 of macro called at line 47, column 9.")
                    /\ pc' = "Done"
               ELSE /\ pc' = "Lbl_4"
         /\ UNCHANGED << ll, tortise >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ IF tortise = hare
               THEN /\ Assert(Cyclic(ll), 
                              "Failure of assertion at line 50, column 13.")
                    /\ pc' = "Done"
               ELSE /\ pc' = "Lbl_1"
         /\ UNCHANGED << ll, tortise, hare >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-7243740de75f1b5183fb8207a2538584
=============================================================================
\* Modification History
\* Last modified Tue Jun 23 14:30:49 MST 2020 by jeremy
\* Created Tue Jun 23 13:53:03 MST 2020 by jeremy
