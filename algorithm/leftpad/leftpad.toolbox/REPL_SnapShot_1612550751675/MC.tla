---- MODULE MC ----
EXTENDS leftpad, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16125507456417000 == 
Leftpad(" ", 5, <<"f", "o", "o">>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16125507456417000>>)
----

=============================================================================
\* Modification History
\* Created Fri Feb 05 11:45:45 MST 2021 by jeremy
