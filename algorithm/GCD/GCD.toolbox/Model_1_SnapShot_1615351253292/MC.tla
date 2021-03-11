---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535124921623000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535124921624000 == 
GCD(2,15)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535124921624000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:40:49 MST 2021 by jerem
