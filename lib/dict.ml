open Print

type name = string ;;

type 'a name_dict_node = Letter of (char * 'a option * 'a name_dict) and 
'a name_dict = 'a name_dict_node list ;;

let no_definition_error = "Trying to use a function that is not defined" ;;

type name_dict_program = Elements.program name_dict ;;
let empty_name_dict_program: name_dict_program = [] ;;

let rec add (key: name) (value: Elements.program) (dict: name_dict_program) =
  let add_aux (key: name) (i: int) (len: int) =
    if len = 0 then dict else
    match dict with
    | [] -> [Letter (key.[i], (if len = 1 then Some value else None), add (String.sub key (i + 1) (len - 1)) value [])]
    | Letter(c, v, dict)::rest ->
      begin
        if c = key.[i] then
          (* On effectue une redéfinition de l'ancien programme *)
          if len = 1 then (Letter(c, Some value, dict))::rest
          else Letter(c, v, add (String.sub key (i + 1) (len - 1)) value dict)::rest
        else
          (Letter(c, v, dict))::(add key value rest)
      end
  in
  add_aux key 0 (String.length key)

(* If the name is not in the dict, will raise Invalid_arg `no_definition_error` *)
let rec lookup (key: name) (dict: name_dict_program): Elements.program =
  let rec lookup_aux (key: name) (i: int) (len: int) (dict: name_dict_program): Elements.program =
    if len = 0 then invalid_arg no_definition_error else
    match dict with
    | [] -> invalid_arg no_definition_error
    | Letter(c, v, d)::rest ->
      begin
        if c = key.[i] then
          if len = 1 then
            begin
              match v with
              | None -> invalid_arg no_definition_error
              | Some v -> v
            end
          else 
            lookup (String.sub key (i + 1) (len - 1)) d
        else
          lookup_aux key i len rest
      end
  in
  lookup_aux key 0 (String.length key) dict

let print_name_dict (dict: name_dict_program) =
  let rec print_name_dict_aux (dict: name_dict_program) (acc: string) =
    match dict with
    | [] -> ()
    | Letter(c, v, d)::rest ->
      begin
        match v with
        | None -> print_name_dict_aux d (acc ^ (String.make 1 c)); print_name_dict_aux rest acc
        | Some v ->
          print_string (acc ^ (String.make 1 c) ^ " -> " );
          print_string "\t\t";
          print_program v;
          print_name_dict_aux d (acc ^ (String.make 1 c)); print_name_dict_aux rest acc
      end
  in
  print_name_dict_aux dict ""

