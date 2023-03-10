------------------------------- MODULE FaceUp -------------------------------


\* This specification models a scene from the movie 
\* "A Brilliant Young Mind" (https://www.youtube.com/watch?v=mYAahN1G8Y8&t=1s)

EXTENDS TLC, Sequences, Naturals, FiniteSets

CONSTANTS NumCards

ASSUME NumCards > 1

VARIABLES Game

Max(xs) == CHOOSE x \in xs :  
            \A y \in xs: y <= x
           
vars == <<Game>>

FlipCard(i) == IF Game[i] = "U" THEN "D" ELSE "U"

\* This is the "magic" part of TLA+
\* 
\* \E means "there exists", however in TLA+ this "branches". 
\* When presented with multiple options, e.g, multiple cards that are face down, 
\* TLA+ tries ALL possible choices. 
MakeMove == \E i \in DOMAIN Game : 
    /\ Game[i] = "D"
    /\ Game' = IF i = Max(DOMAIN Game) THEN [Game EXCEPT ![i] = "U"]
               ELSE [Game EXCEPT ![i] = "U",
                                 ![i+1] = FlipCard(i+1)]
                                 
AllCardsFaceUp == \A i \in DOMAIN Game : Game[i] = "U"

EventuallyAllFaceUp == <>[]AllCardsFaceUp

AllGamesEndFaceUp == []<>AllCardsFaceUp

GameFinished == 
    /\ AllCardsFaceUp 
    /\ UNCHANGED Game

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
\* Last modified Tue Jan 11 11:50:25 MST 2022 by jeremy
\* Created Mon Jan 10 16:04:24 MST 2022 by jeremy
