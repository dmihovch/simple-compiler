package main

import "core:fmt"
import "core:os"
import "core:strings"

run :: proc() -> int {
	num_args := len(os.args)
	if num_args < 2 {
		fmt.eprintln("Usage: ./simple-compiler <file_name>.csam")
		return 1
	}

	fmt.println(os.args)
	
	if !strings.has_suffix(os.args[1], ".csam") {
		fmt.eprintln("file: ", os.args[1], " not a .csam file")
		return 2
	}

	file, err := os.open(os.args[1])
	if err != nil {
		fmt.eprintln("file: ", os.args[1], " cannot be found or cannot be opened")
		return 3
	}
	defer os.close(file)
	
	file_str: string
	file_str, err = read_file_to_string(file)
	if err != nil {
		return 4
	}
	defer delete(file_str)

	fmt.println(file_str)

	toks: [dynamic]Token
	defer delete(toks)
	lexer_errors: [dynamic]Lexer_Error
	defer delete(lexer_errors)

	lexer := init_lexer(file_str, len(file_str))
	lexer.toks = toks
	lexer.errs = lexer_errors
	lexical_analysis(&lexer)
	//report errors and exit or hand off to parser

	fmt.println(toks)
	fmt.println(len(toks))
	
	//testing 
	ok:bool
	file_str ,ok = strings.replace_all(file_str, " ", "")
	file_str , ok= strings.replace_all(file_str, "\n", "")
	fmt.println(len(file_str))

	return 0
}

read_file_to_string :: proc(f: ^os.File) -> (string, os.Error) {
	data, err := os.read_entire_file(f, context.allocator)
	if err != nil {
		return "", err 
	}
	return string(data), nil
}

main :: proc(){
	os.exit(run())	
}
