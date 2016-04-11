%%%%
Nonterminals
object array pairs pair values value scalar literal.

%%%%
Terminals
'[' ']' '{' '}' ',' ':' string number 'true' 'false' 'null'.

%%%% START CATEGORY OF GRAMMAR
Rootsymbol
value.

%%%% GRAMMAR RULES
value   -> scalar.
value   -> object.
value   -> array.

values  -> value ',' values : [ '$1' | '$3' ].
values  -> value            : [ '$1' ].

object  -> '{' pairs '}'    : '$2'.

array   -> '[' ']'          : [].
array   -> '[' values ']'   : '$2'.

pair    -> string ':' value : #{ '$1' => '$3' }.
pairs   -> pair             : '$1'.
pairs   -> pair ',' pairs   : maps:merge('$1', '$3').

scalar  -> string           : token_value('$1').
scalar  -> literal          : '$1'.

literal -> number           : token_value('$1').
literal -> 'true'           : true.
literal -> 'false'          : false.
literal -> 'null'           : nil.

%%%% HELPER FUNCTIONS
Erlang code.
token_value({_Tok, _Line, Value}) -> Value.
