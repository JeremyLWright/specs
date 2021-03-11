---- MODULE MC ----
EXTENDS GCD, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16153507373368000 == 
Divides(2,3)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16153507373368000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:32:17 MST 2021 by jerem
