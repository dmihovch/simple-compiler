package main 

import "core:fmt"
//import "core:strings"

LexError:: enum {
	ILLEGAL_IDENT,
	//and more
}

State :: enum {
	Start,
	Integer,
	Identifier,
	Keyword,
	Invalid,
}

Lexer :: struct {
	source: string,
	pos: int,
	len: int,
	line: int,
	column: int,
}


init_lexer :: proc(source: string, len: int) -> Lexer {
	return Lexer{
		source = source,
		pos = 0,
		len = len,
		line = 1,
		column = 1,
	}
}

parse_error :: proc(e: LexError) -> string {
	switch e {
		case .ILLEGAL_IDENT: return "Illegal Indentifier"
	}
	return "unknown error" 
}

peek :: proc(lex: ^Lexer) -> (u8, bool) {
	if lex.len <= lex.pos+1 {
		return 0, false
	}
	return lex.source[lex.pos+1], true
}

//this is currently garbage
process_next_token :: proc(lex: ^Lexer) -> (Token, LexError){
	//this is da state machine
	lex.pos+=1
	return {kind = .Plus, value = "+"}, nil
}

parse_tokens :: proc(lex: ^Lexer) -> ([dynamic]Token, LexError) {
	toks: [dynamic]Token
	
	for lex.pos < lex.len {
		curch := lex.source[lex.pos]
		if curch == '\n' {
			lex.line+=1
			lex.column=1
			lex.pos+=1
			continue
		}
		if curch == ' ' {
			lex.column+=1
			lex.pos+=1
			continue
		}
		tok, err := process_next_token(lex)
		if err != nil {
			fmt.eprintln("Lexical LexError: ", parse_error(err), " on Line:", lex.line, "|Column:", lex.column)
			return toks, err
		}
		append(&toks, tok)
	}

	return toks, nil
}
