----------------------------- MODULE SonarSweep -----------------------------
(***************************************************************************
As the submarine drops below the surface of the ocean, it automatically performs 
a sonar sweep of the nearby sea floor. On a small screen, the sonar sweep report 
(your puzzle input) appears: each line is a measurement of the sea floor depth as 
the sweep looks further and further away from the submarine.

For example, suppose you had the following report:

199
200
208
210
200
207
240
269
260
263

This report indicates that, scanning outward from the submarine, the sonar sweep found 
depths of 199, 200, 208, 210, and so on.

The first order of business is to figure out how quickly the depth increases, just so 
you know what you're dealing with - you never know if the keys will get carried into 
deeper water by an ocean current or a fish or something.

To do this, count the number of times a depth measurement increases from the previous
 measurement. (There is no measurement before the first measurement.)
 ***************************************************************************)
EXTENDS Naturals, Sequences, FiniteSets, TLC, SequencesExt


\* SonarDepthMeasurements is the input sequence of our sonar measurements

CONSTANT NumberOfMeasurements

\* We expect that all measurements are positive values. 
\* ASSUME \A measurement \in ToSet(SonarDepthMeasurements) : measurement \in Nat
ASSUME NumberOfMeasurements > 0

SonarDepthMeasurements == [1..NumberOfMeasurements -> Nat]

VARIABLES NumberOfIncreases, WorkingSample

vars == <<NumberOfIncreases, WorkingSample>>

NumberOfMeasurementIncreases(samples) == Cardinality({i \in 2..Len(samples) : samples[i] > samples[i-1]})

Init == /\ NumberOfIncreases = 0
        /\ \A sample \in SonarDepthMeasurements : WorkingSample = sample


Next == /\ NumberOfIncreases' = NumberOfMeasurementIncreases(WorkingSample)
        /\ Print(NumberOfIncreases, TRUE)

Spec == Init /\ [][Next]_vars /\ WF_vars(Next)

CountOfAnySetIsLengthOfSet == Cardinality(ToSet(WorkingSample)) = Len(SetToSeq(ToSet(WorkingSample)))


IsCorrect == /\ CountOfAnySetIsLengthOfSet

TypeOK == /\ NumberOfIncreases >= 0
\*          /\ Cardinality(DeltaMeasurements) = Len(SonarDepthMeasurements) - 1 



=============================================================================
\* Modification History
\* Last modified Sat Jan 01 17:34:18 MST 2022 by jerem
\* Created Sat Jan 01 16:46:51 MST 2022 by jerem
