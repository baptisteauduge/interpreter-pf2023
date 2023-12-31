type arithmetic_operators = 
  | ADD
  | LESS
  | TIMES
  | DIVIDE

type stack_operators =
  | DUP
  | DROP
  | SWAP
  | ROT

type compare_operators =
  | EQUAL
  | LT
  | GT
  | DIFF

type operators =
  | AOP of arithmetic_operators
  | SOP of stack_operators
  | COP of compare_operators

type element = 
  | AOP of arithmetic_operators
  | SOP of stack_operators
  | COP of compare_operators
  | INT of int
  | MOT of string
  | BOOL of bool
  | IF
  | THEN
  | ELSE
  | ENDIF
  | COLON
  | SEMICOLON

type program = element list
let other_accepted_separators: char list = ['\r'; '\n'; '\t']

let convert_other_accepted_separators (c: char): char =
  let is_accepted_separator (c: char): bool =
    List.mem c other_accepted_separators in
  if is_accepted_separator c then ' ' else c

let to_string (e: element): string =
  match e with
  | SOP DUP -> "DUP"
  | SOP DROP -> "DROP"
  | SOP SWAP -> "SWAP"
  | SOP ROT -> "ROT"
  | AOP ADD -> "+"
  | AOP LESS -> "-"
  | AOP TIMES -> "*"
  | AOP DIVIDE -> "/"
  | COP EQUAL -> "="
  | COP LT -> "<"
  | COP GT -> ">"
  | COP DIFF -> "<>"
  | INT i -> string_of_int i
  | MOT s -> s
  | IF -> "IF"
  | THEN -> "THEN"
  | ELSE -> "ELSE"
  | ENDIF -> "ENDIF"
  | BOOL true -> "TRUE"
  | BOOL false -> "FALSE"
  | COLON -> ":"
  | SEMICOLON -> ";"

let to_element (s: string): element =
  match s with
  | "DUP" -> SOP DUP
  | "DROP" -> SOP DROP
  | "SWAP" -> SOP SWAP
  | "ROT" -> SOP ROT
  | "+" -> AOP ADD
  | "-" -> AOP LESS
  | "*" -> AOP TIMES
  | "/" -> AOP DIVIDE
  | "=" -> COP EQUAL
  | "<" -> COP LT
  | ">" -> COP GT
  | "<>" -> COP DIFF
  | "IF" -> IF
  | "THEN" -> THEN
  | "ELSE" -> ELSE
  | "ENDIF" -> ENDIF
  | "TRUE" -> BOOL true
  | "FALSE" -> BOOL false
  | ":" -> COLON
  | ";" -> SEMICOLON
  | s ->
    begin
      match int_of_string_opt s with
      | None -> MOT s
      | Some value -> INT value
    end

let parse (input: string): program =
  let space_string: string = String.map convert_other_accepted_separators input in
  let split_string_multi: string list = String.split_on_char ' ' space_string in
  let split_string: string list = List.filter ((<>) "") split_string_multi in
  let rec parse_aux (l: string list) (acc: element list) =
    match l with
    | [] -> List.rev acc
    | x::xs -> parse_aux xs ((to_element x)::acc)
  in
  parse_aux split_string []

let text (input: program): string =
  let rec element_list_to_str_lst (l: program) (acc: string list) =
    match l with
    | [] -> List.rev acc
    | x::xs -> element_list_to_str_lst xs ((to_string x)::acc)
  in
  String.concat " " (element_list_to_str_lst input [])
