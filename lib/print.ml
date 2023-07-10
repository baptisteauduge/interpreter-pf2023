open Stack
open Elements

let rec print_stack (s: stack): unit =
  match s with
  | [] -> print_newline ()
  | (INT i)::rest -> print_int i; print_string " "; print_stack rest
  | (BOOL b)::rest -> print_string (string_of_bool b); print_string " "; print_stack rest

let rec print_program (program: program): unit =
  match program with
  | [] -> print_newline ()
  | elem::rest -> print_string (to_string elem); print_string " "; print_program rest

