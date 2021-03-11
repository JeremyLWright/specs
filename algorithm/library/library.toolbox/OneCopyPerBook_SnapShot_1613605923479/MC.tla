---- MODULE MC ----
EXTENDS library, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
George, Harold
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
Bible
----

\* MV CONSTANT definitions People
const_1613605915437133000 == 
{George, Harold}
----

\* MV CONSTANT definitions Books
const_1613605915437134000 == 
{Bible}
----

\* CONSTANT definitions @modelParameterConstants:0NumCopies
const_1613605915437135000 == 
1..1
----

=============================================================================
\* Modification History
\* Created Wed Feb 17 16:51:55 MST 2021 by jeremy
