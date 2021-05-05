---- MODULE tictactoe ----

EXTENDS TLC, Sequences, FiniteSets, Integers

VARIABLES board, currentPlayer

vars == <<board, currentPlayer>>

Init == /\ board = << 
            <<"-", "-", "-">>,
            <<"-", "-", "-">>,
            <<"-", "-", "-">> >>
        /\ currentPlayer = "X"

WinningPositions == 
    {
        \* Row Wins
        {<<1, 1>>, <<1, 2>>, <<1, 3>>},
        {<<2, 1>>, <<2, 2>>, <<2, 3>>},
        {<<3, 1>>, <<3, 2>>, <<3, 3>>},

        \* Column Wins
        {<<1, 1>>, <<2, 2>>, <<3, 2>>},
        {<<1, 2>>, <<2, 2>>, <<3, 2>>},
        {<<1, 2>>, <<2, 2>>, <<3, 2>>},

        \* Diagonal Wins
        {<<1, 1>>, <<2, 2>>, <<3, 3>>},
        {<<1, 3>>, <<2, 2>>, <<3, 1>>}
    }
        
AllCells == (DOMAIN board) \X (DOMAIN board[1])

CellIsOpen(idx) == board[idx[1]][idx[2]] = "-"

OpenCells == {idx \in AllCells : CellIsOpen(idx)}


Marks == {"X", "O", "-"}


Range(f) == { f[x] : x \in DOMAIN f }

OpenCellsInRow(row) == {cell \in DOMAIN row : CellIsOpen(cell)}


\* Wrong version of Positions
\* Positions(player) ==
\*    /\ \A <<row, col>> \in AllCells : board[row][col] = player 

Positions(player) == {<<row, col>> \in AllCells : board[row][col] = player} 
    

PlayerWon(player) == \E wp \in WinningPositions : wp \subseteq Positions(player)
\* OpenCells :: [(Int, Int)]

PlayerXGoes == 
    \E <<row, col>> \in OpenCells : 
               board' = [ board EXCEPT ![row][col] = "X" ]

PlayerOGoes == 
    \E <<row, col>> \in OpenCells : 
               board' = [ board EXCEPT ![row][col] = "O" ]
   
Winner == IF PlayerWon("X") THEN "X"
          ELSE IF PlayerWon("O") THEN "O"
          ELSE "No Winner. It's a Draw."

OpenCellsAreOpen == OpenCells \subseteq Positions("-")

BoardFull == Cardinality(OpenCells) = 0

GameEnded == BoardFull \/ PlayerWon("X") \/ PlayerWon("O")


CellsHaveValidMarks == 
    /\ \A <<row, col>> \in AllCells : board[row][col] \in Marks

TypeOk == 
    /\ CellsHaveValidMarks
    /\ OpenCellsAreOpen

switchPlayer == IF currentPlayer = "X" THEN currentPlayer' = "O" ELSE currentPlayer' = "X"

Next ==
    \/ ~GameEnded
        /\ 
            \/ currentPlayer = "X" \* Enabling condition
                /\ PlayerXGoes
            \/ currentPlayer = "O"
                /\ PlayerOGoes
        /\ switchPlayer
    \/ GameEnded
        /\ 
            \/ Winner \in {"X", "O"}
                /\ PrintT(Winner \o " won!")
            \/ Winner \notin {"X", "O"}
                /\ PrintT(Winner)
        /\ UNCHANGED vars

Spec == Init /\ [][Next]_vars
\* How can I get a REPL?



\* TODO
\* 1. Define what win, or finished/full means
\* 2. A game finished. 
====