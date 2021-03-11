---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_161535126170827000 ==
1..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_161535126170828000 == 
GCD(5,15)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161535126170828000>>)
----

=============================================================================
\* Modification History
\* Created Tue Mar 09 21:41:01 MST 2021 by jerem
