---- MODULE tictactoe ----

EXTENDS TLC

VARIABLES board

Init == board = 
         << <<"-", "-", "-">>,
            <<"-", "-", "-">>,
            <<"-", "-", "-">> >>


Marks == {"X", "O", "-"}

CellIsOpen(cell) == cell = "-"

\*PlayerXGoes == 
 \*   /\ cell' = "X" = CHOOSE cell \in board[1] : CellIsOpen(cell) = cell'
    
AllRowsHaveThree == TRUE

\* I Cannot make this one worlk
\* AllCells == \A cells \in rows: \A rows \in board: TRUE


CellsHaveValidMarks == 
    \* This doesn't work because tuples are "non enumerable"???
    \* /\ \A cell \in board[1] : cell \in Marks 
    \* /\ \A cell \in board[2] : cell \in Marks
    \* /\ \A cell \in board[3] : cell \in Marks
    \* This doesn't work because tuples are "non enumerable"???
    \* /\ CHOOSE x \in board[1] : x \in Marks
    \* /\ CHOOSE x \in board[2] : x \in Marks
    \* /\ CHOOSE x \in board[3] : x \in Marks
    /\ \A row \in {1,2,3} : \A cell \in {1,2,3} : board[row][cell] \in Marks


TypeOk == 
    /\ AllRowsHaveThree
    /\ CellsHaveValidMarks

Next == board' = board

====