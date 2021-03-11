---- MODULE MC ----
EXTENDS GCD, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16153507288966000 == 
Divides(2,4)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16153507288966000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:32:08 MST 2021 by jerem
