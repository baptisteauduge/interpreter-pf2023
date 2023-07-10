open Pf23.Eval ;;
open Pf23.Dict ;;
open Pf23.Elements ;;

(* insert_new_func *)
let program1_str = "FO 2 + ; 4 FO" ;;
let program1 = parse program1_str ;;
assert ((insert_new_func empty_name_dict_program program1) = ([ Letter ('F', None, [Letter('O', Some [INT 2; AOP ADD], [])])], [INT 4; MOT "FO"])) ;;
let program2_str = "FACT DUP 1 > IF DUP 1 - FACT * THEN ; 6 FACT" ;;
let program2 = parse program2_str ;;
let dict2: name_dict_program = [ Letter ('F', None, [Letter('A', None, [Letter('C', None, [Letter('T', Some [SOP DUP; INT 1; COP GT; IF; SOP DUP; INT 1; AOP LESS; MOT "FACT"; AOP TIMES; THEN], [])])])])] ;;
assert ((insert_new_func empty_name_dict_program program2) = (([ Letter ('F', None, [Letter('A', None, [Letter('C', None, [Letter('T', Some [SOP DUP; INT 1; COP GT; IF; SOP DUP; INT 1; AOP LESS; MOT "FACT"; AOP TIMES; THEN], [])])])])]), [INT 6; MOT "FACT"])) ;;

(* insert_func_in_prog *)
assert ((insert_func_in_prog  dict2 "FACT" [INT 4; INT 6]) = [SOP DUP; INT 1; COP GT; IF; SOP DUP; INT 1; AOP LESS; MOT "FACT"; AOP TIMES; THEN; INT 4; INT 6]) ;;
assert (
  try 
    (insert_func_in_prog empty_name_dict_program "FACT" [INT 4; INT 6]) |> fun (_) -> false
  with Invalid_argument _ -> true
);;

(* eval_if_else *)
assert (
  (eval_if_else [BOOL true] [INT 1; INT 4; THEN; INT 6])
  = ([], [INT 1; INT 4; INT 6])
);;
assert (
  (eval_if_else [BOOL false] [INT 1; INT 4; THEN; INT 6])
  = ([], [INT 6])
);;
assert (
  (eval_if_else [BOOL false] [INT 1; ELSE; INT 4; ENDIF; INT 6])
  = ([], [INT 4; INT 6])
);;
assert (
  (eval_if_else [BOOL true] [INT 1; ELSE; INT 4; ENDIF; INT 6])
  = ([], [INT 1; INT 6])
);;
assert (
  try 
  (eval_if_else [INT 1] [INT 1; ELSE; INT 4; ENDIF; INT 6] = ([], [INT 1; INT 6]) |> fun (_) -> false)
  with Invalid_argument _ -> true
) ;;
assert (
  try 
  (eval_if_else [BOOL true] [ENDIF; INT 6] = ([], [INT 1; INT 6]) |> fun (_) -> false)
  with Invalid_argument _ -> true
)

(* eval *)
let program3_str = ": CARRE DUP * ; 2 CARRE 4 CARRE +"
let program3 = parse program3_str ;;
assert (
  (eval empty_name_dict_program [] program3)
  = [INT 20]
);;
let program4_str = ": FACT DUP 1 > IF DUP 1 - FACT * THEN ; 6 FACT" ;;
let program4 = parse program4_str ;;
assert (
  (eval empty_name_dict_program [] program4)
  = [INT 720]
) ;;
assert (
  try
    (eval empty_name_dict_program [] program2) |> fun (_) -> false
  with Invalid_argument _ -> true
) ;;
let program5_str = ": FIB DUP 1 > IF DUP 1 - FIB SWAP 2 - FIB + THEN ; 6 FIB" ;;
let program5 = parse program5_str ;;
assert (
  (eval empty_name_dict_program [] program5)
  = [INT 8]
) ;;