---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535085626111000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535085626112000 == 
Divides(2,3)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535085626112000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:34:16 MST 2021 by jerem
