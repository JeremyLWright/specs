---- MODULE clock ----

EXTENDS TLC, Sequences, FiniteSets, Integers, FiniteSetsExt


CONSTANTS ticks, counter
VARIABLES clk, wallClk

vars == <<clk, wallClk>>

\* Generate a monotonic clock suitable for timestamping a record to send to a 
\* remote system
Send(wallticks) == 
    IF clk[ticks] = wallticks THEN 
        clk' = [clk EXCEPT ![counter] = clk[counter] + 1]
    ELSE 
        clk' = [clk EXCEPT ![ticks] = Max({clk[ticks], wallticks})]


Recv(thisClk, otherClk) == TRUE

WallClockUpdate(delta) == wallClk' = wallClk + delta

LogicalTime(hlc) == hlc[ticks] * 1 + hlc[counter]

Init ==
    /\ clk = (ticks :> 0) @@ (counter :> 0)
    /\ wallClk = 0

Next == 
    \/ Send(wallClk) /\ UNCHANGED wallClk
    \/ \E delta \in {-1, 0, 1} : WallClockUpdate(delta) /\ UNCHANGED clk
    \/ UNCHANGED vars

DebugTicksIsLessThan0 == clk[ticks] = 0


ClkAlwaysIncreases == [][clk[ticks] > 0 => LogicalTime(clk') > LogicalTime(clk)]_clk


Spec == Init /\ [][Next]_vars

====