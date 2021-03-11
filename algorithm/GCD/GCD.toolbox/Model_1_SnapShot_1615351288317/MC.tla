---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535128324435000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535128324436000 == 
GCD(15,30)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535128324436000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:41:23 MST 2021 by jerem
