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
const_1613606897749178000 == 
{George, Harold}
----

\* MV CONSTANT definitions Books
const_1613606897749179000 == 
{Bible, HitchhikersGuide}
----

\* CONSTANT definitions @modelParameterConstants:0NumCopies
const_1613606897749180000 == 
1..1
----

=============================================================================
\* Modification History
\* Created Wed Feb 17 17:08:17 MST 2021 by jeremy
