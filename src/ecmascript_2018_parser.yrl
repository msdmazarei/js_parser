Nonterminals
    literal
    array_literal
    primaryExpression
    root
    elision
    member_expression
    expression
    meta_property
    super_property
    arguments
    new_target
    new_expression
    call_expression
    cover_call_expression_and_async_arrow_head
    super_call
    argument_list
    assignment_expression
    left_hand_side_expression
    arrow_function
    yeild_expression
    conditional_expression
    async_arrow_function
    assignment_operator
    conditional_expression
    logical_or_expression
    logical_and_expression
    bitwise_or_expression
    bitwise_xor_expression
    bitwise_and_expression
    equality_expression
    relational_expression
    shift_expression
    additive_expression
    multiplicative_expression
    multiplicative_operator
    exponentiation_expression
    unary_expression
    await_expression
    update_expression
    .

Terminals
    identifier_name
    this
    null_literal
    boolean_literal
    numeric_literal
    string_literal
    regular_expression_literal
    template
    template_substituation
    new
    super
    target
    '['
    ']'
    ','
    '.'
    ')'
    '('
    '...'
    '='
    '*='
    '/='
    '%='
    '+='
    '-='
    '<<='
    '>>='
    '>>>='
    '&='
    '^='
    '|='
    '**='
    '?'
    ':'
    '&&'
    '||'
    '|'
    '^'
    '&'
    '=='
    '!='
    '==='
    '!=='
    '<'
    '>'
    '<='
    '>='
    'instanceof'
    'in'
    '<<'
    '>>>'
    '>>'
    '++'
    '--'
    '+'
    '-'
    '*'
    '/'
    '%'
    '**'
    delete
    void
    typeof
    '!'
.

Rootsymbol
   root
.



root -> left_hand_side_expression : '$1'.

primaryExpression -> this : '$1'.
primaryExpression -> identifier_name : '$1'.
primaryExpression -> literal: '$1' .
primaryExpression -> array_literal : '$1'.

literal -> null_literal : '$1'.
literal -> boolean_literal : '$1'.
literal -> numeric_literal : '$1'.
literal -> string_literal : '$1'.
literal -> regular_expression_literal : '$1'.

array_literal -> '['']' : {array,[]}.
array_literal -> '[' elision ']' : {array,lists:flatten(['$2'])}.
elision -> ',' : {comma,','}.
elision -> primaryExpression ',' : '$1' .
elision -> primaryExpression ',' elision : lists:flatten(['$1','$3']).


member_expression -> primaryExpression : '$1'.
member_expression -> member_expression '[' expression ']' : {member_expression, '$1','$2','$3'}.
member_expression -> member_expression '.' identifier_name : {member_expression, '$1','$2','$3'}.
member_expression -> member_expression template_substituation : {member_expression,'$1',template_substituation,'$2'}.
member_expression -> member_expression template : {member_expression,'$1', template ,'$2'}.
member_expression -> super_property : {member_expression,super_property,'$1'}.
member_expression -> meta_property : {member_expression , meta_property,'$1'}.
member_expression -> new member_expression arguments : {member_expression,'$1','$2','$3'}.

super_property -> super '[' expression ']' : {super_property, '$1','$2'}.
super_property -> super '.' identifier_name : {super_property, '$1','$2'}.

meta_property -> new_target : '$1'.

new_target -> new '.' target : {new_target}.

new_expression -> member_expression : {new_expression, '$1'}.
new_expression -> new new_expression : {new_expression, '$1','$2'}.

call_expression -> cover_call_expression_and_async_arrow_head : {call_expression,'$1'}.
call_expression -> super_call : {call_expression, '$1'}.
call_expression -> call_expression arguments : {call_expression,'$1','$2'}.
call_expression -> call_expression '[' expression ']': {call_expression,'$1','$2','$3'}.
call_expression -> call_expression '.' identifier_name : {call_expression, '$1','$2','$3'}.
call_expression -> call_expression template_substituation : {call_expression, '$1','$2'}.
call_expression -> call_expression template : {call_expression, '$1','$2'}.

super_call -> super arguments : {super_call, '$2'}.

arguments -> '(' ')' : {arguments,empty}.
arguments -> '(' argument_list ')' : {arguments, '$2'}.
arguments -> '(' argument_list ',' ')' : {arguments, '$2'}.

argument_list -> assignment_expression : {argument_list,'$1'}.
argument_list -> '...' assignment_expression : {argument_list,'$2'}.
argument_list -> argument_list ','  assignment_expression : {argument_list,'$1','$3'}.
argument_list -> argument_list ',' '...' assignment_expression : {argument_list,'$1','$3','$4'}.

left_hand_side_expression -> new_expression : {left_hand_side_expression,'$1'}.
left_hand_side_expression -> call_expression : {left_hand_side_expression, '$1'}.

expression -> assignment_expression : {expression , '$1'}.
expression -> expression assignment_expression : {expression, '$1','$2'}.

assignment_expression -> conditional_expression : {assignment_expression,cond,'$1'}.
assignment_expression -> yeild_expression : {assignment_expression,yeild,'$1'}.
assignment_expression -> arrow_function : {assignment_expression,arrow_func,'$1'}.
assignment_expression -> async_arrow_function : {assignment_expression,async_arrow_func,'$1'}.
assignment_expression -> left_hand_side_expression '=' assignment_expression : {assignment_expression,'$1','$2','$3'}.
assignment_expression -> assignment_expression assignment_operator assignment_expression : {assignment_expression,'$1','$2','$3'}.

assignment_operator -> '*=' : {assignment_operator,'$1'}.
assignment_operator -> '/=' : {assignment_operator,'$1'}.
assignment_operator -> '%=' : {assignment_operator,'$1'}.
assignment_operator -> '+=' : {assignment_operator,'$1'}.
assignment_operator -> '-=' : {assignment_operator,'$1'}.
assignment_operator -> '<<=' : {assignment_operator,'$1'}.
assignment_operator -> '>>=' : {assignment_operator,'$1'}.
assignment_operator -> '>>>=' : {assignment_operator,'$1'}.
assignment_operator -> '&=' : {assignment_operator,'$1'}.
assignment_operator -> '^=' : {assignment_operator,'$1'}.
assignment_operator -> '|=' : {assignment_operator,'$1'}.
assignment_operator -> '**=' : {assignment_operator,'$1'}.


conditional_expression -> logical_or_expression : {conditional_expression,'$1'}.
conditional_expression -> logical_or_expression '?' assignment_expression ':' assignment_expression : {conditional_expression,'$1','$2','$3','$5'}.

logical_or_expression -> logical_and_expression : {logical_or_expression,'$1'}.
logical_or_expression -> logical_or_expression '||' logical_and_expression : {logical_or_expression,'$1','$2','$3'}.

logical_and_expression -> bitwise_or_expression : {logical_and_expression,'$1'}.
logical_and_expression -> logical_and_expression '&&' bitwise_or_expression : {logical_and_expression,'$1','$2','$3'}.

bitwise_or_expression -> bitwise_xor_expression : {bitwise_or_expression,'$1'}.
bitwise_or_expression -> bitwise_or_expression '|' bitwise_xor_expression : {bitwise_or_expression,'$1','$2','$3'}.

bitwise_xor_expression -> bitwise_and_expression : {bitwise_xor_expression,'$1'}.
bitwise_xor_expression -> bitwise_xor_expression '^' bitwise_and_expression : {bitwise_xor_expression,'$1','$2','$3'}.

bitwise_and_expression -> equality_expression : {bitwise_and_expression, '$1'}.
bitwise_and_expression -> bitwise_and_expression '&' equality_expression : {bitwise_and_expression,'$1','$2','$3'}.


equality_expression -> relational_expression : '$1'.
equality_expression -> equality_expression '==' relational_expression : {equality_expression,'$1','$2','$3'}.
equality_expression -> equality_expression '!=' relational_expression : {equality_expression,'$1','$2','$3'}.
equality_expression -> equality_expression '===' relational_expression : {equality_expression,'$1','$2','$3'}.
equality_expression -> equality_expression '!==' relational_expression : {equality_expression,'$1','$2','$3'}.


relational_expression -> shift_expression : '$1'.
relational_expression -> relational_expression '<' shift_expression : {relational_expression,'$1','$2','$3'}.
relational_expression -> relational_expression '>' shift_expression : {relational_expression,'$1','$2','$3'}.
relational_expression -> relational_expression '<=' shift_expression : {relational_expression,'$1','$2','$3'}.
relational_expression -> relational_expression '>=' shift_expression : {relational_expression,'$1','$2','$3'}.
relational_expression -> relational_expression instanceof shift_expression : {relational_expression,'$1','$2','$3'}.
relational_expression -> relational_expression in shift_expression : {relational_expression,'$1','$2','$3'}.

shift_expression -> additive_expression : '$1'.
shift_expression -> shift_expression  '<<' additive_expression : {shift_expression,'$1','$2','$3'}.
shift_expression -> shift_expression  '>>' additive_expression : {shift_expression,'$1','$2','$3'}.
shift_expression -> shift_expression  '>>>' additive_expression : {shift_expression,'$1','$2','$3'}.

additive_expression -> multiplicative_expression : '$1'.
additive_expression -> additive_expression '+' multiplicative_expression : {additive_expression,'$1','$2','$3'}.
additive_expression -> additive_expression '-' multiplicative_expression : {additive_expression,'$1','$2','$3'}.

multiplicative_expression -> exponentiation_expression : '$1'.
multiplicative_expression -> multiplicative_expression multiplicative_operator exponentiation_expression : {multiplicative_expression,'$1','$2','$3'}.

multiplicative_operator -> '*' : '$1'.
multiplicative_operator -> '/' : '$1'.
multiplicative_operator -> '%' : '$1'.


exponentiation_expression -> unary_expression : '$1'.
exponentiation_expression -> unary_expression '**' exponentiation_expression : {exponentiation_expression,'$1','$2','$3'}.

unary_expression -> update_expression : '$1'.
unary_expression -> delete unary_expression : {unary_expression,'$1','$2'}.
unary_expression -> void unary_expression : {unary_expression,'$1','$2'}.
unary_expression -> typeof unary_expression : {unary_expression,'$1','$2'}.
unary_expression -> '!' unary_expression : {unary_expression,'$1','$2'}.
unary_expression -> '+' unary_expression : {unary_expression,'$1','$2'}.
unary_expression -> '-' unary_expression : {unary_expression,'$1','$2'}.
unary_expression -> await_expression : '$1'.

update_expression -> left_hand_side_expression : '$1'.
update_expression -> left_hand_side_expression '++' : {update_expression,'$1','$2'}.
update_expression -> left_hand_side_expression '--' : {update_expression,'$1','$2'}.
update_expression -> '++' unary_expression : {update_expression,'$1','$2'}.
update_expression -> '--' unary_expression : {update_expression,'$1','$2'}.


Erlang code.

unwrap({int, Line, Value}) -> {int, Line, list_to_integer(Value)}.