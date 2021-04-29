---- MODULE tictactoe ----

EXTENDS TLC 

VARIABLES board, currentPlayer

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
        


Marks == {"X", "O", "-"}

CellIsOpen(idx) == board[idx[1]][idx[2]] = "-"

Range(f) == { f[x] : x \in DOMAIN f }

OpenCellsInRow(row) == {cell \in DOMAIN row : CellIsOpen(cell)}

AllCells == (DOMAIN board) \X (DOMAIN board[1])

\* OpenCells :: [(Int, Int)]
OpenCells == {idx \in AllCells : CellIsOpen(idx)}

PlayerXGoes == 
    \E <<row, col>> \in OpenCells : 
               board' = [ board EXCEPT ![row][col] = "X" ]

PlayerOGoes == 
    \E <<row, col>> \in OpenCells : 
               board' = [ board EXCEPT ![row][col] = "O" ]
   

\* AllRowsHaveThree == TRUE
\*     \* /\ Len(<<x>> : x \in (DOMAIN board[1])) = 3

OpenCellsAreOpen ==
    /\ \A <<row, col>> \in OpenCells : board[row][col] = "-" 

Xs ==
    /\ \A <<row, col>> \in AllCells : board[row][col] = "X" 

Os ==
    /\ \A <<row, col>> \in AllCells : board[row][col] = "O" 

CellsHaveValidMarks == 
    /\ \A row \in DOMAIN board : \A col \in DOMAIN board[row] : board[row][col] \in Marks

TypeOk == 
    /\ CellsHaveValidMarks
    /\ OpenCellsAreOpen

switchPlayer == IF currentPlayer = "X" THEN currentPlayer' = "O" ELSE currentPlayer' = "X"

Next ==
    \/ 
        /\ currentPlayer = "X" \* Enabling condition
        /\ PlayerXGoes
        /\ switchPlayer
    \/ 
        /\ currentPlayer = "O"
        /\ PlayerOGoes
        /\ switchPlayer
    \/

\* A win is defined as 1 player getting verticle row, horizontal row, or cross
XWins == Xs \in WinningPositions
OWins == Xs \in WinningPositions
\* How can I get a REPL?



\* TODO
\* 1. Define what win, or finished/full means
\* 2. A game finished. 
====