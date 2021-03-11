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
const_1613606782397163000 == 
{George}
----

\* MV CONSTANT definitions Books
const_1613606782397164000 == 
{Bible, HitchhikersGuide}
----

\* CONSTANT definitions @modelParameterConstants:0NumCopies
const_1613606782397165000 == 
1..1
----

=============================================================================
\* Modification History
\* Created Wed Feb 17 17:06:22 MST 2021 by jeremy
