---- MODULE MCDieHarder ----
EXTENDS TLC, DieHarder

CONSTANTS
big, medium, small

\* capacitiesConst == (big :> 5) @@ (small :> 3)
capacitiesConst == (big :> 6) @@ (medium :> 5) @@ (small :> 3)

IntRange == 1..1000 

====