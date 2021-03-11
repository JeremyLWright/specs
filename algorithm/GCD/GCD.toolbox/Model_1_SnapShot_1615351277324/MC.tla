---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535127319531000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535127319532000 == 
GCD(15,25)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535127319532000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:41:13 MST 2021 by jerem
