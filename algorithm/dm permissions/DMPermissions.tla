--------------------------- MODULE DMPermissions ---------------------------

(***************************************************************************)
(* Permissive - Anyone can send you a DM (this is what we have today)      *)
(* Exploratory - Only members of the communities you are in can DM you.    *)
(* Engaging - Only members of your personal community can DM you.          *)
(* Private - No one can DM you.                                            *)
(*                                                                         *)
(***************************************************************************)


EXTENDS TLC, Sequences, Naturals, FiniteSets

CONSTANTS NumCards

ASSUME NumCards > 1

VARIABLES MyCommunityMembers, MemoMembers, ManuallyListMembers, MyCommunities


Members(community) == TRUE\*Returns members from that community *\

Permissive(member) == TRUE

Exploratory(member) == member \in Members(MyCommunties) \/ member \in ManuallyListMembers

Engaging(member) == member \in MyCommunityMembers \/ member \in ManuallyListMembers

Private(member) == member \in ManuallyListMembers

\* Initialized the game to an "array" of all face-down cards
Init == \E size \in 1..NumCards : 
            Game = [i \in 1..size |-> "D"] 

Next == 
    \/ AllCardsFaceUp /\ GameFinished
    \/ MakeMove

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)

TypeOK == \A i \in DOMAIN Game : Game[i] \in {"U", "D"}

=============================================================================
\* Modification History
\* Last modified Wed Aug 17 09:25:12 MST 2022 by jeremy
\* Created Mon Jan 10 16:04:24 MST 2022 by jeremy


=============================================================================
\* Modification History
\* Created Wed Aug 17 09:18:21 MST 2022 by jeremy
