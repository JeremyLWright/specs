---- MODULE MC ----
EXTENDS GCD, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16153506696385000 == 
Divides(2,4)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16153506696385000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:31:09 MST 2021 by jerem
