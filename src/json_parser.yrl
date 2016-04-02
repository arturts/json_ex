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
value   -> scalar           : '$1'.
value   -> object           : '$1'.
value   -> array            : '$1'.

values  -> value ',' values : [ '$1' | '$2' ].
values  -> value            : [ '$1' ].

object  -> '{' pairs '}'    : '$2'.

array   -> '[' ']'          : [].
array   -> '[' values ']'   : '$2'.

pair    -> string ':' value : #{ '$1' => '$3' }.
pairs   -> pair             : '$1'.
pairs   -> pair ',' pairs   : maps:merge('$1', '$2').

scalar  -> string           : list_to_binary(token_value('$1')).
scalar  -> literal          : '$1'.

literal -> number           : list_to_float(token_value('$1')).
literal -> 'true'           : true.
literal -> 'false'          : false.
literal -> 'null'           : nil.

%%%% HELPER FUNCTIONS
Erlang code.
token_value({_Tok, _Line, Value}) -> Value.
