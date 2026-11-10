package main

import "core:fmt"
import "core:os"


read_file_to_string :: proc(f: ^os.File) -> (string, os.Error) {
	data, err := os.read_entire_file(f, context.allocator)
	if err != nil {
		return "", err 
	}
	return string(data), nil
}

main :: proc(){
	fmt.println("this will be a simple compiler! hopefully")
	
	num_args := len(os.args)
	if num_args < 2 {
		fmt.eprintln("Usage: ./simple-compiler <file>")
		return
	}

	fmt.println(os.args)
	file, err := os.open(os.args[1])
	if err != nil {
		fmt.eprintln("file: ", os.args[1], " cannot be found or cannot be opened")
		return
	}
	defer os.close(file)
	
	file_str: string
	file_str, err = read_file_to_string(file)
	if err != nil {
		return
	}
	defer delete(file_str)

	fmt.println(file_str)

	toks := parse_tokens("+")
	defer delete(toks)
	fmt.println(toks)

	return 
}
