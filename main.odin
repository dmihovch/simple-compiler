package main

import "core:fmt"

main :: proc(){
	fmt.println("this will be a simple compiler! hopefully")
	toks := parse_tokens("+")
	defer delete(toks)
	fmt.println(toks)
}
