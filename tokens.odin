package main 

Token_Kind :: enum {
	Identifier,
	Integer,
	Plus,
	Minus,
	Multiply,
	Divide,
	Modulo,
	Equal,
	Equal_Equal,
	Semicolon,
	LParen,
	RParen,
	Keyword_int,
	Keyword_ret,
	EOF,
}

Token :: struct {
	kind: Token_Kind,
	value: string
}

