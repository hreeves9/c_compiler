open Ast

exception Foo of string

let parse_exp tokens = 
	match tokens with
	| i::rest -> (AST.Const(AST.Int(int_of_string i)), rest)
	| [] -> raise (Foo "no expression")
;;

let rec parse_statement_list tokens =
	match tokens with
	| ";":: rest -> parse_statement_list rest
	| "RETURN"::";"::rest -> let extra_statements, rest = parse_statement_list rest in
								AST.Return::extra_statements, rest
	| "RETURN"::rest -> let exp, rest = parse_exp rest in
						let extra_statements, rest = parse_statement_list rest in
						AST.ReturnVal(exp)::extra_statements, rest
	| _ -> ([], tokens)
;;

let parse_body tokens = 
	let statements, rest = parse_statement_list tokens in
	match rest with
	| "}"::[] -> AST.Body(statements)
	| _ -> raise (Foo "no closing brace man")
;;

let rec parse_params tokens =
	match tokens with
	| ")"::rest -> ([], rest)
	| "INT"::name::rest -> let extra_params, rest = parse_params rest in 
								(AST.Param(AST.IntType, AST.ID(name))::extra_params, rest)
	| _ -> raise (Foo "i can't believe you've done this (parse params)")
;;

let parse tokens = 
	let func_return_type, func_name, rest = 
		match tokens with
		| "INT"::name::"("::rest -> (AST.IntType, AST.ID(name), rest)
		| _ -> raise (Foo "oh no (func type)")
	in 
	let func_params, rest = parse_params rest in
	let func_body = 
		match rest with
		| "{"::rest -> parse_body rest
		| _ -> raise (Foo "no opening brace man")
	in
		AST.FunDecl(func_return_type, func_name, func_params, func_body)
;;

let parser tokens = AST.Prog(parse tokens)