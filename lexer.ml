let explode s = List.init (String.length s) (String.get s);;

let implode list =
   let convert_to_string list = List.map (fun x -> (String.make 1 x))list in
   String.concat "" (convert_to_string list)
;;

let first_element tokList =
  match tokList with
  | [] -> " "
  | first_element::restOfList -> first_element

let remove_nonalphanumeric = 
  Str.global_replace(Str.regexp "[^a-zA-Z0-9]+") " ";;


let check_for_keyword currentTextString=

  let tokList = Str.split(Str.regexp "[ ]") (remove_nonalphanumeric currentTextString) in
  let token = first_element tokList in
  match token with
  | "int" -> "INT"
  | "return" -> "RETURN"
  | _ -> token  
;;


let rec check_for_symbol myList = 
  let lexList = [] in
  match myList with
  | [] -> lexList
    | '{'::restOfList -> "{"::(check_for_symbol restOfList)
    | '}'::restOfList -> "}"::(check_for_symbol restOfList)
    | '('::restOfList -> "("::(check_for_symbol restOfList)
    | ')'::restOfList -> ")"::(check_for_symbol restOfList)
    | ';'::restOfList -> ";"::(check_for_symbol restOfList)
    | ' '::restOfList -> check_for_symbol restOfList
    | c::restOfList -> begin
              let token = check_for_keyword (implode(c::restOfList)) in
              let listString = implode (c::restOfList) in
              let tokenLength = String.length token in
              let newList = explode (String.sub listString (tokenLength) ((String.length listString) - tokenLength)) in
              token::(check_for_symbol newList)
             end
;;