open Pf23.Elements
open Pf23.Eval
open Pf23.Dict
open Pf23.Stack
open Pf23.Print
open Pf23.Default_functions

let print_motd () = print_endline "\nWelcome to PF23, a PostScript-style stack language\nType 'list func' to list available functions\nType 'quit' to exit\n"

let get_user_input () =
  print_string  "PF23> ";
  read_line ()

let handle_input input dict stack =
  try
    let program = parse input in
    let (dict, stack) = eval dict stack program in
    print_newline ();
    print_stack stack;
    print_newline ();
    dict, stack
  with
  | Invalid_argument s -> print_endline ("\nError: " ^ s); dict, stack
  | Failure s -> print_endline ("\nError: " ^ s); dict, stack

let print_functions dict =
  print_newline ();
  print_endline "Available functions :";
  print_name_dict dict;
  print_newline ()

let rec loop dict stack =
  match get_user_input () with
  | "quit" -> print_endline "Bye!"
  | "list func" -> print_functions dict; loop dict stack
  | user_input -> match handle_input user_input dict stack with
    | (dict, stack) -> loop dict stack

let () =
  print_motd ();
  let (dict, stack) = eval empty_name_dict_program empty_stack default_definitions in
  loop dict stack
