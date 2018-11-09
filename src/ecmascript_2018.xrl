Definitions.
UPPERRANGE= A-Z
LOWERRANGE = a-z
ALPHARANGE = {UPPERRANGE}{LOWERRANGE}
NUMRANGE = 0-9
ALPHANUMRANGE = {ALPHARANGE}{NUMRANGE}
ALPHANUMERIC = [{ALPHARANGE}{NUMRANGE}]
ALPHAS = [{UPPERRANGE}{LOWERRANGE}]
DOLLAR = \$
UNDERSCORE = _
SLASH = \/
ASTERISK = \*
TAB = \x09
VT = \x0B
FF = \x0C
SP = \x20
NBSP = \xA0

WHITESPACE = {TAB}|{VT}|{FF}|{SP}|{NBSP}


LF = \x0A
CR = \x0D

LINETERMINATOR = {LF}|{CR}
LINETERMINATORSEQ = {LINETERMINATOR}|{CR}{LF}

SingleLineCommentChar = [^{LINETERMINATOR}]
SingleLineCommentChars = {SingleLineCommentChar}{SingleLineCommentChar}+
SingleLineComment = \/\/{SingleLineCommentChars}?

MultiLineNotAsteriskChar = [^\*]
MultiLineNotForwardSlashOrAsteriskChar = [^\/\*]
SLASH_ASTERISK = {SLASH}{ASTERISK}
ASTERISK_SLASH = {ASTERISK}{SLASH}

IDENTIFIER_START = [{ALPHARANGE}{DOLLAR}{UNDERSCORE}]
IDENTIFIER_PART = [{ALPHANUMRANGE}{DOLLAR}{UNDERSCORE}]
IDENTIFIER_NAME = {IDENTIFIER_START}{IDENTIFIER_PART}+|{IDENTIFIER_START}

NOT_SPECIAL_CHAR = [^{WHITESPACE}{LINETERMINATORSEQ}{ASTERISK}{SLASH}]
NOT_SPECIAL_CHARS = {NOT_SPECIAL_CHAR}{NOT_SPECIAL_CHAR}+

KEYWORD = (await|break|case|catch|class|const|continue|debugger|default|delete|do|else|export|extends|finally|for|function|if|import|in|instanceof|new|return|super|switch|this|throw|try|typeof|var|void|whiile|with|yeild)
FUTURE_RESERVED_WORDS = (enum|implements|package|protected|interface|private|public)

NULL_LITERAL = null
BOOLEAN_LITERAL = (true|false)
RESERVED_WORD = {KEYWORD}|{FUTURE_RESERVED_WORDS}|{NULL_LITERAL}|{BOOLEAN_LITERAL}


PUNCTUATOR = (\*\*|\+\+|\-\-|<<|>>>|>>|&&|\|\||\+=|\-=|\*=|%=|\*\*=|<<=|>>>=|&=|\|=|\^=|=>|>>=|!==|====|!=|<=|>=|==|[\{\(\)\[\]\.\;\,<>=+\-\*%&\^\|!~\?:])
DIV_PUNCTUATOR =(\/|\/=)
RIGHT_BRACE_PUNCTUATOR = }


DECIMAL_DIGIT = [0-9]
DECIMAL_DIGITS = ({DECIMAL_DIGIT}+)

NON_ZERO_DIGIT = [1-9]
DECIMAL_INTEGER_LITERAL = (0|{NON_ZERO_DIGIT}{DECIMAL_DIGITS}*)

POS_SIGN = \+
NEG_SIGN = \-
POINT = \.

SIGNED_INTEGER = ({DECIMAL_DIGITS}|{POS_SIGN}{DECIMAL_DIGITS}|{NEG_SIGN}{DECIMAL_DIGITS})

EXPONENT_INDICATOR = (e|E)
EXPONENT_PART = ({EXPONENT_INDICATOR}{SIGNED_INTEGER})

DECIMAL_LITERAL_1 = {DECIMAL_INTEGER_LITERAL}{POINT}({DECIMAL_DIGITS})?{EXPONENT_PART}?
DECIMAL_LITERAL_2 = {POINT}{DECIMAL_DIGITS}{EXPONENT_PART}?
DECIMAL_LITERAL_3 = {DECIMAL_INTEGER_LITERAL}{EXPONENT_PART}?
DECIMAL_LITERAL = {DECIMAL_LITERAL_1}|{DECIMAL_LITERAL_2}|{DECIMAL_LITERAL_3}

BINARY_DIGIT = (0|1)
BINARY_DIGITS = {BINARY_DIGIT}+
BINARY_INTEGER_LITERAL = (0b{BINARY_DIGITS}|0B{BINARY_DIGITS})

OCTAL_DIGIT = [01234567]
OCTAL_DIGITS = {OCTAL_DIGIT}+
OCTAL_INTEGER_LITERAL = (0o{OCTAL_DIGITS}|0O{OCTAL_DIGITS})

HEX_DIGIT = [0123456789abcdefABCDEF]
NOT_HEX_DIGIT = [^0123456789abcdefABCDEF]
HEX_DIGITS = {HEX_DIGIT}+
HEX_INTEGER_LITERAL = (0x{HEX_DIGITS}|0X{HEX_DIGITS})

NUMERIC_LITERAL = {DECIMAL_LITERAL}|{BINARY_INTEGER_LITERAL}|{OCTAL_INTEGER_LITERAL}|{HEX_INTEGER_LITERAL}

SingleEscapeCharacter = [\'\"\\bfnctv]
CharacterEscapeSequence = {SingleEscapeCharacter}
HexEscapeSequence = x{HEX_DIGIT}{HEX_DIGIT}
Hex4Digits = {HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}
UnicodeEscapeSequence = u{Hex4Digit}
EscapeSequence = {CharacterEscapeSequence}|{HexEscapeSequence}|{UnicodeEscapeSequence}
LineContinuation = (\\({LINETERMINATORSEQ}))

DoubleStringCharacter = ({LineContinuation}|[^\"\\{CR}{LF}]|\\{EscapeSequence})
SingleStringCharacter = ({LineContinuation}|[^\'\\{CR}{LF}]|\\{EscapeSequence})
StringLiteral = (\"{DoubleStringCharacter}*\"|\'{SingleStringCharacter}*\')



%% REGULAR EXPRESSION
RegularExpressionFlags = {IDENTIFIER_PART}*
RegularExpressionNonTerminator = [^{CR}{LF}]
RegularExpressionBackSlashSequence = \\{RegularExpressionNonTerminator}
RegularExpressionClassChar = ([^{CR}{LF}\\\]]|{RegularExpressionBackSlashSequence})
RegularExpressionClassChars = {RegularExpressionClassChar}*
RegularExpressionClass = \[{RegularExpressionClassChars}\]
RegularExpressionChar = ([^{CR}{LF}\\\/\[]|{RegularExpressionBackSlashSequence}|{RegularExpressionClass})
RegularExpressionChars = {RegularExpressionChar}*
RegularExpressionFirstChar = ([^{CR}{LF}\*\\\/\[]|{RegularExpressionBackSlashSequence}|{RegularExpressionClass})
RegularExpressionBody = ({RegularExpressionFirstChar}{RegularExpressionChars})
RegularExpressionLiteral = \/{RegularExpressionBody}\/{RegularExpressionFlags}

%%Template
NotEscapeSequence_1 = 0{DECIMAL_DIGIT}|{NON_ZERO_DIGIT}|x{HEX_DIGIT}?{NOT_HEX_DIGIT}|u[^0123456789abcdefABCDEF\{]
NotEscapeSequence_2 = u{HEX_DIGIT}{NOT_HEX_DIGIT}|u{HEX_DIGIT}{HEX_DIGIT}{NOT_HEX_DIGIT}|u\{{NOT_HEX_DIGIT}
NotEscpaeSequence = ({NotEscapeSequence_1}|{NotEscapeSequence_2})
TemplateCharacter = (\$[^\{]|\\{EscapeSequence}|\{NotEscapeSequence}|{LineContinuation}|{LINETERMINATORSEQ}|[^\`\\\${CR}{LF}])
TemplateCharacters = ({TemplateCharacter}+)
TemplateTail = \}{TemplateCharacters}?\`
TemplateMiddle = \}{TemplateCharacters}?\$\{
TemplateSubstituation = ({TemplateMiddle}|{TemplateTail})
TemplateHead = \`{TemplateCharacters}?\$\{
NoSubstituationTemplate = \`{TemplateCharacters}?\`
Template = ({NoSubstituationTemplate}|{TemplateHead})

Rules.


{WHITESPACE} : {token,{whitespace,TokenLine,TokenChars}}.
{PUNCTUATOR} : {token, {punctuator,TokenLine,TokenChars}}.
{LINETERMINATORSEQ} : {token,{line_terminator_seq ,TokenLine,TokenChars}}.
{SingleLineComment} : {token,{single_line_comment,TokenLine,TokenChars}}.
{SLASH_ASTERISK} : {token, {slash_asterisk,TokenLine,TokenChars}}.
{ASTERISK_SLASH} : {token , {asterisk_slash, TokenLine,TokenChars}}.
{RESERVED_WORD} : {token , {reserved_word, TokenLine,TokenChars}}.
{NUMERIC_LITERAL} : {token , {numeric_literal,TokenLine,TokenChars}}.
{IDENTIFIER_NAME} : {token, {identifier_name,TokenLine,TokenChars}}.
{DIV_PUNCTUATOR} : {token , {div_punctuator , TokenLine, TokenChars}}.
{RIGHT_BRACE_PUNCTUATOR} : {token , {right_brace_punctuator,TokenLine,TokenChars}}.
{StringLiteral} : {token , {string_literal,TokenLine,TokenChars}}.
{RegularExpressionLiteral} : {token , {regular_expression, TokenLine,TokenChars}}.
{Template} : {token , {template , TokenLine,TokenChars}}.
{TemplateSubstituation} : {token , {template_substituation,TokenLine,TokenChars}}.
%%{NOT_SPECIAL_CHARS} : {token,{not_special_chars,TokenLine,TokenChars}}.


Erlang code.

