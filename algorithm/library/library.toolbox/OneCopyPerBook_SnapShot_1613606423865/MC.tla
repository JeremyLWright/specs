---- MODULE MC ----
EXTENDS library, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
George
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
Bible, HitchhikersGuide
----

\* MV CONSTANT definitions People
const_1613606415827148000 == 
{George}
----

\* MV CONSTANT definitions Books
const_1613606415827149000 == 
{Bible, HitchhikersGuide}
----

\* CONSTANT definitions @modelParameterConstants:0NumCopies
const_1613606415827150000 == 
1..1
----

=============================================================================
\* Modification History
\* Created Wed Feb 17 17:00:15 MST 2021 by jeremy
