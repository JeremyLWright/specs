---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535086533015000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535086533016000 == 
Divides(2,4)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535086533016000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:34:25 MST 2021 by jerem
