open Ast



let generate ast =
	let outFile = open_out "assembly.s" in

	Printf.fprintf outFile "    .globl _main\n";

	let generate_statement = function
	| AST.Return -> Printf.fprintf outFile "ret"
	| AST.ReturnVal(AST.Const(AST.Int i)) ->
		Printf.fprintf outFile "    movl    $%d, %%eax\n" i;
		Printf.fprintf outFile "    ret"


	in

	let generate_statements statements = List.iter generate_statement statements

	in

	let generate_func f =
	match f with
	| AST.FunDecl(fun_type, AST.ID(fun_name), fun_params, AST.Body(statements)) ->
		let _ = Printf.fprintf outFile "_%s:\n" fun_name in
		generate_statements statements
	in

	match ast with
	|AST.Prog f -> generate_func f;

	close_out outFile
;;
