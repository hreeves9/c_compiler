module AST = 
	struct
		type const = 
			| Int of int
		type type_def = 
			| IntType
			| CharType
		type exp = Const of const
		type statement =
			| Return 
			| ReturnVal of exp
		type id = ID of string
		type fun_param = Param of type_def * id
		type fun_body = Body of statement list
		type fun_decl = FunDecl of type_def * id * fun_param list * fun_body
		type prog = Prog of fun_decl
	end