package main 

import "core:fmt"

Lexer_Error_Kind:: enum {
	ILLEGAL_IDENT,
	//and more
}

Lexer_Error :: struct {
	kind: Lexer_Error_Kind,
	row: int,
	col: int,
}

Lexer :: struct {
	source: string,
	pos: int,
	len: int,
	row: int,
	col: int,

	toks: [dynamic]Token,
	errs: [dynamic]Lexer_Error,
}

init_lexer :: proc(source: string, len: int) -> Lexer {
	return Lexer{
		source = source,
		pos = 0,
		len = len,
		row = 1,
		col= 1,
	}
}

//maybe an error, need to check if the append can fail
emit_token :: proc(lex: ^Lexer){
	//TODO
}

advance :: proc(lex: ^Lexer){
	lex.pos += 1
}

scan_number :: proc(lex: ^Lexer){
	//declare start
	//pos will be end
	//TODO
}

scan_identifier :: proc(lex: ^Lexer){
	//TODO
}

peek :: proc(lex: ^Lexer) -> (u8, bool) {
	if lex.len <= lex.pos+1 {
		return 0, false
	}
	return lex.source[lex.pos+1], true
}

is_digit :: proc(c: u8) -> bool {
	return c >= '0' && c <= '9'
}

is_alpha :: proc(c: u8) -> bool {
	return c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z'
}

is_ident_start :: proc(c: u8) -> bool{
	return is_alpha(c) || c == '_'
}

is_ident_continue :: proc(c: u8) -> bool {
	return is_ident_start(c) || is_digit(c)
}

//this is currently garbage
lexical_analysis :: proc(lex: ^Lexer) {
	for lex.pos < lex.len {
		ch := lex.source[lex.pos]
		switch {
		case is_digit(ch): 
		case is_alpha(ch):
		case is_ident_start(ch):
		case is_ident_continue(ch):
		case ch == '(':
		case ch == ')':
		case ch == '+':
		case ch == '-':
		case ch == '/':
		case ch == '*':
		case ch == '%':
		case ch == '=':
		case ch == '\n':
			lex.pos += 1
			lex.col = 1
			lex.row += 1
		case ch == ' ':
			lex.pos += 1
			lex.col += 1
		case:
			//Lexical Error
			lex.pos += 1
			lex.col += 1
		}

	}

}
