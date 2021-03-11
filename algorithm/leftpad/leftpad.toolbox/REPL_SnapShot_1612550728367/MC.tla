---- MODULE MC ----
EXTENDS leftpad, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16125507219385000 == 
Leftpad(" ", 1, <<"f", "o", "o">>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16125507219385000>>)
----

=============================================================================
\* Modification History
\* Created Fri Feb 05 11:45:21 MST 2021 by jeremy
