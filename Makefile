make:
	ocamlc -o aaa str.cma lexer.cmo compiler.ml
	./aaa

build: 
	ocamlc str.cma lexer.ml
	ocamlc -o aaa str.cma lexer.cmo compiler.ml
	./aaa

clean:
	rm compiler.cmi lexer.cmi compiler.cmo lexer.cmo aaa a.out