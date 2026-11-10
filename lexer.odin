package main 

parse_tokens :: proc(raw_file: string) -> [dynamic]Token {
	toks: [dynamic]Token
	
	dummy_tok: Token = {
		kind = .Operator,
		value = raw_file 
	} 

	append(&toks, dummy_tok)

	return toks 
}
