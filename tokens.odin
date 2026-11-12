package main 

Token_Kind :: enum {
	Identifier,
	Integer,
	Plus,
	Plus_Plus,
	Plus_Equal,
	Minus,
	Minus_Minus,
	Minus_Equal,
	Star,
	Star_Equal,
	Divide,
	Divide_Equal,
	Modulo,
	Modulo_Equal,
	Equal,
	Equal_Equal,
	Semicolon,
	LParen,
	RParen,
	Keyword_int,
	Keyword_return,
	EOF,
}

Token :: struct {
	kind: Token_Kind,
	value: string,
	row: int,
	col: int,
}

