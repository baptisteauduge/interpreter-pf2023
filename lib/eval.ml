open Dict
open Stack
open Elements

let invalid_prog_def: string = "Invalid program definition"
let invalid_name_def: string = "Invalid name definition in program"
let invalid_if_else: string = "Invalid if else statement"
let unexpected_semicolon: string = "Unexpected semicolon"

(* returns: new_dict, rest_of_program *)
let insert_new_func (dict: name_dict_program) (program: program): (name_dict_program * program) =
  (* returns : new_program, rest_of_the_current_prog *)
  let rec get_func_def (program: program) (res_prog: program): (program * program) =
    match program with
    | [] -> invalid_arg invalid_prog_def
    | SEMICOLON::rest -> (List.rev res_prog, rest)
    | elem::rest -> get_func_def rest (elem::res_prog)
  in
  
  (* returns : name, rest_of_the_current_prog *)
  let get_name (program: program): (name * program) =
    match program with
    | [] -> invalid_arg invalid_prog_def
    | (MOT name)::rest -> (name, rest)
    | _::_ -> invalid_arg invalid_name_def
  in
  let name, rest = get_name program in
  let new_program, rest = get_func_def rest [] in
  (add name new_program dict, rest)

(* return new_program *)
let insert_func_in_prog (dict: name_dict_program) (func_name: name) (program: program): program =
  let func_def_rev = List.rev (lookup func_name dict) in
  let rec insert_func (func_def: program) (res_prog: program): program =
    match func_def with
    | [] -> res_prog
    | elem::rest -> insert_func rest (elem::res_prog)
  in
insert_func func_def_rev program

let eval_if_else (s: stack) (program: program): (stack * program) =
  let rec get_else (program: program) (else_prog: program): (program * program) =
    match program with
    | [] -> invalid_arg invalid_if_else
    | ENDIF::rest -> (else_prog, rest)
    | elem::rest -> get_else rest (elem::else_prog)
    in

  let rec get_if (program: program) (if_prog: program) (else_prog: program): (program * program * program) =
    match program with
    | [] -> invalid_arg invalid_if_else
    | THEN::rest -> (if_prog, else_prog, rest)
    | ELSE::rest -> get_else rest else_prog |> fun (else_prog, rest) -> (if_prog, else_prog, rest)
    (* Si on croise ENDIF ici, ça signifie qu'on a pas encore croisé ELSE, ce qui est une erreur de synthaxe *)
    | ENDIF::_ -> invalid_arg invalid_if_else
    | elem::rest -> get_if rest (elem::if_prog) else_prog
  in

  match s with
  | (BOOL b)::rest_stack -> 
    if b then
      let if_prog, _, rest = get_if program [] [] in
      (* TODO SUPPRIMER LE @ *)
      (rest_stack, (List.rev if_prog)@ rest)
    else
      let _, else_prog, rest = get_if program [] [] in
      (* TODO SUPPRIMER LE @ *)
      (rest_stack, (List.rev else_prog) @ rest)
  | _ -> invalid_arg invalid_if_else

let rec eval (dict: name_dict_program) (s: stack) (program: program): (name_dict_program * stack) =
  match program with
  | [] -> dict, s
  | COLON::rest -> insert_new_func dict rest |> fun (new_dict, rest) -> eval new_dict s rest
  (* Si on croise une semicolon ici, c'est qu'il y a une erreur de syntaxe *)
  | SEMICOLON::_ -> invalid_arg unexpected_semicolon
  | (MOT prog)::rest -> insert_func_in_prog dict prog rest |> fun new_prog -> eval dict s new_prog
  | IF::rest -> eval_if_else s rest |> fun (new_stack, rest) -> eval dict new_stack rest
  (* Si on croise THEN, ELSE ou ENDIF a ce niveau, c'est qu'il y a une erreur de syntaxe *)
  | THEN::_ -> invalid_arg invalid_if_else
  | ELSE::_ -> invalid_arg invalid_if_else
  | ENDIF::_ -> invalid_arg invalid_if_else
  | elem::rest -> eval dict (step s elem) rest
