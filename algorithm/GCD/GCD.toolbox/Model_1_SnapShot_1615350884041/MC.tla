---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535088097219000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535088097220000 == 
Divides(2,5)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535088097220000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:34:40 MST 2021 by jerem
