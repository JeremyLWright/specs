---- MODULE door ----

EXTENDS TLC, Sequences, FiniteSets, Integers


(*--algorithm door

variables 
    open = FALSE,
    locked = FALSE,
    key \in BOOLEAN;

process open_door = "Open Door"
begin
    OpenDoor:
        await open;
        either \* lock/unlock
            locked := ~locked;
        or \* close the door
            await ~locked;
            open := FALSE;
        end either;
        goto OpenDoor;
end process

process closed_door = "Closed Door"
begin 
    ClosedDoor:
        await ~open;
        either \* locked/unlocked
            await key;
            locked := ~locked;
        or 
            await ~locked;
            open := TRUE;
        end either;
        goto ClosedDoor;
end process;

end algorithm; *)

\* BEGIN TRANSLATION (chksum(pcal) = "945d449e" /\ chksum(tla) = "e1c1d0fb")
VARIABLES open, locked, key, pc

vars == << open, locked, key, pc >>

ProcSet == {"Open Door"} \cup {"Closed Door"}

Init == (* Global variables *)
        /\ open = FALSE
        /\ locked = FALSE
        /\ key \in BOOLEAN
        /\ pc = [self \in ProcSet |-> CASE self = "Open Door" -> "OpenDoor"
                                        [] self = "Closed Door" -> "ClosedDoor"]

OpenDoor == /\ pc["Open Door"] = "OpenDoor"
            /\ open
            /\ \/ /\ locked' = ~locked
                  /\ open' = open
               \/ /\ ~locked
                  /\ open' = FALSE
                  /\ UNCHANGED locked
            /\ pc' = [pc EXCEPT !["Open Door"] = "OpenDoor"]
            /\ key' = key

open_door == OpenDoor

ClosedDoor == /\ pc["Closed Door"] = "ClosedDoor"
              /\ ~open
              /\ \/ /\ key
                    /\ locked' = ~locked
                    /\ open' = open
                 \/ /\ ~locked
                    /\ open' = TRUE
                    /\ UNCHANGED locked
              /\ pc' = [pc EXCEPT !["Closed Door"] = "ClosedDoor"]
              /\ key' = key

closed_door == ClosedDoor

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == open_door \/ closed_door
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

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
