---- MODULE tictactoe ----

EXTENDS TLC 

VARIABLES board

Init == board = << <<"-", "-", "-">>,
            <<"-", "-", "-">>,
            <<"-", "-", "-">> >>


Marks == {"X", "O", "-"}

CellIsOpen(idx) == board[idx[1]][idx[2]] = "-"

Range(f) == { f[x] : x \in DOMAIN f}

OpenCellsInRow(row) == {cell \in DOMAIN row : CellIsOpen(cell)}

AllCells == (DOMAIN board) \X (DOMAIN board[1])

\* OpenCells :: [(Int, Int)]
OpenCells == {idx \in AllCells : CellIsOpen(idx)}

\*LET cells == {}
\* OpenCells == {<<row, cell>> : row \in DOMAIN board : OpenCells(board[row])}

PlayerXGoes == 
   /\ CHOOSE cell \in OpenCells : board'[cell[1]][cell[2] = "X" 
   

AllRowsHaveThree == TRUE
    \*/\ Len(<<x>> : x \in (DOMAIN board[1])) = 3

OpenCellsAreOpen ==
    /\ \A idx \in OpenCells : board[idx[1]][idx[2]] = "-" \* Is this right? 

CellsHaveValidMarks == 
    \* This doesn't work because tuples are "non enumerable"???
    \* /\ \A cell \in board[1] : cell \in Marks 
    \* /\ \A cell \in board[2] : cell \in Marks
    \* /\ \A cell \in board[3] : cell \in Marks
    \* This doesn't work because tuples are "non enumerable"???
    \* /\ CHOOSE x \in board[1] : x \in Marks
    \* /\ CHOOSE x \in board[2] : x \in Marks
    \* /\ CHOOSE x \in board[3] : x \in Marks
    /\ \A row \in DOMAIN board : \A cell \in DOMAIN board[row] : board[row][cell] \in Marks


TypeOk == 
    /\ AllRowsHaveThree
    /\ CellsHaveValidMarks
    /\ OpenCellsAreOpen

Next ==
    board' = board
    \* /\ PlayerXGoes

====