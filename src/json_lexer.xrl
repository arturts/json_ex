Definitions.

% <Macro Definitions>
STRING        = "([^"\\]|\\(["\\\/bfnrt]|u[0-9a-fA-F]{4}))*"
D             = [0-9]
INTEGER       = -?{D}+
FLOAT         = -?{D}(\.{D}+)?([eE][+-]?{D}+)?
BOOLEAN       = (true|false)
NULL          = null
WHITESPACE    = [\s\t\n\r]
START_OBJECT  = \{
START_ARRAY   = \[
END_OBJECT    = \}
END_ARRAY     = \]
COLON         = \:
COMMA         = \,

Rules.

% <Token Rules>
{STRING}        : {token, {string, TokenLine, list_to_binary(strip_double_quotes(TokenChars))}}.
{INTEGER}       : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}         : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{BOOLEAN}       : {token, {bool, TokenLine, list_to_atom(TokenChars)}}.
{NULL}          : {token, {nil, TokenLine, nil}}.
{COLON}         : {token, {colon, TokenLine, TokenChars}}.
{COMMA}         : {token, {comma, TokenLine, TokenChars}}.
{START_OBJECT}  : {token, {start_obj, TokenLine, TokenChars}}.
{START_ARRAY}   : {token, {start_arr, TokenLine, TokenChars}}.
{END_OBJECT}    : {token, {end_obj, TokenLine, TokenChars}}.
{END_ARRAY}     : {token, {end_arr, TokenLine, TokenChars}}.
{WHITESPACE}    : skip_token.

Erlang code.
% <Erlang Code>
strip_double_quotes(String) -> string:strip(String, both, $\").
