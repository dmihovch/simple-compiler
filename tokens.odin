package main 

Token_Kind :: enum {
	Identifier,
	Integer,
	Operator,
	Punctuation,
	EOF,
}

Token :: struct {
	kind: Token_Kind,
	value: string
}
