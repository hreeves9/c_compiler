make:
	ocamlc -o aaa str.cma lexer.cmo compiler.ml
	./aaa

build: 
	ocamlc ast.ml
	ocamlc generate.ml
	ocamlc str.cma lexer.ml
	ocamlc parser.ml
	ocamlc -o aaa str.cma lexer.cmo parser.cmo generate.cmo compiler.ml
	./aaa

clean:
	rm compiler.cmi lexer.cmi compiler.cmo lexer.cmo aaa a.out generate.cmi generate.cmo parser.cmi parser.cmo ast.cmi ast.cmo