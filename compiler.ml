let stripchars s =
  let len = String.length s in
  let res = Bytes.create len in
  let rec aux i j =
    if i >= len
    then Bytes.to_string (Bytes.sub res 0 j)
    else if String.contains "\n" s.[i] then
      aux (succ i) (j)
    else begin
      Bytes.set res j s.[i];
      aux (succ i) (succ j)
    end
  in
  aux 0 0
  ;;

let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  (Bytes.unsafe_to_string s);
  (*stripchars s;*)
  ;;



let () =
  let fileContent = load_file "/Users/harveyreeves/Desktop/c_compiler/return_2.c" in
  let x = stripchars fileContent in
  let explodedList = Lexer.explode x in 
  let symbolList = Lexer.check_for_symbol explodedList in
  List.iter (Printf.printf "%s\n") symbolList
;;



(* #TODO
 * - create git repo
 * - parse the symbols
 * - profit
 *
 *)
