---- MODULE MC ----
EXTENDS leftpad, TLC

\* Constant expression definition @modelExpressionEval
const_expr_161440879065125000 == 
Leftpad(" ", 5, <<"f", "o", "o">>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161440879065125000>>)
----

=============================================================================
\* Modification History
\* Created Fri Feb 26 23:53:10 MST 2021 by jeremy
