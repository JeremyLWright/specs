---- MODULE MC ----
EXTENDS library, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
George, Harold
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
Bible, HitchhikersGuide
----

\* MV CONSTANT definitions People
const_161440856172910000 == 
{George, Harold}
----

\* MV CONSTANT definitions Books
const_161440856172911000 == 
{Bible, HitchhikersGuide}
----

\* CONSTANT definitions @modelParameterConstants:0NumCopies
const_161440856172912000 == 
1..1
----

=============================================================================
\* Modification History
\* Created Fri Feb 26 23:49:21 MST 2021 by jeremy
