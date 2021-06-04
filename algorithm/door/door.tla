---- MODULE door ----

EXTENDS TLC, Sequences, FiniteSets, Integers


(*--algorithm door

variables 
    open = FALSE,
    locked = FALSE,
    key \in BOOLEAN;
begin
    Event:
        either \* unlock 
            await locked /\ (open \/ key);
            locked := FALSE;
        or \* lock
            await ~locked /\ (open \/ key);
            locked := TRUE;

        or \* open
            await ~locked /\ ~open;
            open := TRUE;
        or \* close
            await open;
            open := FALSE;
        end either;
    goto Event;

end algorithm; *)

\* BEGIN TRANSLATION (chksum(pcal) = "d0abb3c0" /\ chksum(tla) = "ff1579c5")
VARIABLES open, locked, key, pc

vars == << open, locked, key, pc >>

Init == (* Global variables *)
        /\ open = FALSE
        /\ locked = FALSE
        /\ key \in BOOLEAN
        /\ pc = "Event"

Event == /\ pc = "Event"
         /\ \/ /\ locked /\ (open \/ key)
               /\ locked' = FALSE
               /\ open' = open
            \/ /\ ~locked /\ (open \/ key)
               /\ locked' = TRUE
               /\ open' = open
            \/ /\ ~locked /\  ~open
               /\ open' = TRUE
               /\ UNCHANGED locked 
            \/ /\ open
               /\ open' = FALSE
               /\ UNCHANGED locked
         /\ pc' = "Event"
         /\ key' = key

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Event
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 


\* Init == /\ open = FALSE
\*         /\ locked = TRUE
\*         /\ key \in BOOLEAN
\*     
\* Next ==
\*     \/ locked
\*         /\ 
\*             (open \/ key) \* if we're locked and open or we have the key, e.g., open or we can open with the key
\*                 /\ locked' = FALSE
\*     \/ ~locked
\*         /\ 
\*             (open \/ key) \* we're unlocked and we have the key, we can lock
\*                 /\ locked' = TRUE
\* 
\* Spec == Init /\ [][Next]_vars


        
\* AllCells == (DOMAIN board) \X (DOMAIN board[1])

\* CellIsOpen(idx) == board[idx[1]][idx[2]] /= "-"





\* OpenCells == {idx \in AllCells : CellIsOpen(idx)}


\* Marks == {"X", "O", "-"}


\* Range(f) == { f[x] : x \in DOMAIN f }

\* OpenCellsInRow(row) == {cell \in DOMAIN row : CellIsOpen(cell)}


\* Wrong version of Positions
\* Positions(player) ==
\*    /\ \A <<row, col>> \in AllCells : board[row][col] = player 

\* Positions(player) == {<<row, col>> \in AllCells : board[row][col] = player} 
\*     
\* 
\* PlayerWon(player) == \E wp \in WinningPositions : wp \subseteq Positions(player)
\* \* OpenCells :: [(Int, Int)]
\* 
\* PlayerXGoes == 
\*     \E <<row, col>> \in OpenCells : 
\*                board' = [ board EXCEPT ![row][col] = "X" ]
\* 
\* PlayerOGoes == 
\*     \E <<row, col>> \in OpenCells : 
\*                board' = [ board EXCEPT ![row][col] = "O" ]
\*    
\* Winner == IF PlayerWon("X") THEN "X"
\*           ELSE IF PlayerWon("O") THEN "O"
\*           ELSE "No Winner. It's a Draw."
\* 
\* OpenCellsAreOpen == OpenCells \subseteq Positions("-")
\* 
\* BoardFull == Cardinality(OpenCells) = 0
\* 
\* GameEnded == BoardFull \/ PlayerWon("X") \/ PlayerWon("O")
\* 
\* 
\* CellsHaveValidMarks == 
\*    /\ \A <<row, col>> \in AllCells : board[row][col] \in Marks

TypeOk == 
    /\ locked \in BOOLEAN 
    /\ key \in BOOLEAN 
    /\ open \in BOOLEAN 


\* Study Questions
\* How can I get a REPL? -> Jupiter Notebooks



\* TODO
\* DONE! 1. Define what win, or finished/full means
\* 2. Define strageties
\* 3. Specifiy a probable winner given stragties
====
