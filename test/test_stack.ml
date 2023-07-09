(* push *)
assert ((Pf23.Stack.push [INT 2; INT 3] (INT 1)) = [INT 1; INT 2; INT 3]) ;;
assert ((Pf23.Stack.push [] (INT 1)) = [INT 1]) ;;
assert ((Pf23.Stack.push [INT 1] (INT 2)) = [INT 2; INT 1]) ;;

(* pop *)
assert ((Pf23.Stack.pop [INT 1; INT 2; INT 3]) = (INT 1, [INT 2; INT 3])) ;;
assert ((Pf23.Stack.pop [INT 1]) = (INT 1, [])) ;;
assert (
  try 
    match Pf23.Stack.pop [] with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
) ;;

(* eval_aop *)
assert ((Pf23.Stack.eval_aop [INT 1; INT 2] PLUS) = [INT 3]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 2; INT 44] PLUS) = [INT 3; INT 44]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 2] MINUS) = [INT (-1)]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 2; INT 10] MINUS) = [INT (-1); INT 10]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 3] TIMES) = [INT 3]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 3; INT 5; INT 10] TIMES) = [INT 3; INT 5; INT 10]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 2] DIVIDE) = [INT 0]) ;;
assert ((Pf23.Stack.eval_aop [INT 1; INT 2; INT 3] DIVIDE) = [INT 0; INT 3]) ;;

(* eval_sop *)
assert ((Pf23.Stack.eval_sop [INT 1] DUP) = [INT 1; INT 1]) ;;
assert ((Pf23.Stack.eval_sop [INT 1; INT 2] DUP) = [INT 1; INT 1; INT 2]) ;;
assert (( 
  try 
    match Pf23.Stack.eval_sop [] DUP with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;
assert ((Pf23.Stack.eval_sop [INT 1] DROP) = []) ;;
assert ((Pf23.Stack.eval_sop [INT 1; INT 2] DROP) = [INT 2]) ;;
assert ((
  try 
    match Pf23.Stack.eval_sop [] DROP with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;
assert ((Pf23.Stack.eval_sop [INT 1; INT 2] SWAP) = [INT 2; INT 1]) ;;
assert ((Pf23.Stack.eval_sop [INT 2; INT 1; INT 3] SWAP) = [INT 1; INT 2; INT 3]) ;;
assert ((
  try 
    match Pf23.Stack.eval_sop [INT 1] SWAP with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;
assert ((Pf23.Stack.eval_sop [INT 1; INT 2; INT 3] ROT) = [INT 2; INT 3; INT 1]) ;;
assert ((Pf23.Stack.eval_sop [INT 1; INT 2; INT 3; INT 4] ROT) = [INT 2; INT 3; INT 1; INT 4]) ;;
assert ((
  try 
    match Pf23.Stack.eval_sop [INT 1] ROT with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;

(* eval_cop *)
assert ((Pf23.Stack.eval_cop [INT 1; INT 2] EQUAL) = [BOOL false]) ;;
assert ((Pf23.Stack.eval_cop [INT 1; INT 1] EQUAL) = [BOOL true]) ;;
assert ((
  try 
    match Pf23.Stack.eval_cop [INT 1] EQUAL with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;
assert ((Pf23.Stack.eval_cop [INT 1; INT 2] LT) = [BOOL true]) ;;
assert ((Pf23.Stack.eval_cop [INT 2; INT 1] LT) = [BOOL false]) ;;
assert ((
  try 
    match Pf23.Stack.eval_cop [INT 1] LT with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;
assert ((Pf23.Stack.eval_cop [INT 1; INT 2] GT) = [BOOL false]) ;;
assert ((Pf23.Stack.eval_cop [INT 2; INT 1] GT) = [BOOL true]) ;;
assert ((
  try 
    match Pf23.Stack.eval_cop [INT 1] GT with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;
assert ((Pf23.Stack.eval_cop [INT 1; INT 2] DIFF) = [BOOL true]) ;;
assert ((Pf23.Stack.eval_cop [INT 1; INT 1] DIFF) = [BOOL false]) ;;
assert ((
  try 
    match Pf23.Stack.eval_cop [INT 1] DIFF with
    | _ -> false
  with Failure error when error = Pf23.Stack.empty_stack_error -> true
)) ;;

(* step *)
assert ((Pf23.Stack.step [INT 1; INT 2] (AOP PLUS)) = [INT 3]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (AOP MINUS)) = [INT (-1)]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (AOP TIMES)) = [INT 2]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (AOP DIVIDE)) = [INT 0]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (SOP DUP)) = [INT 1; INT 1; INT 2]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (SOP DROP)) = [INT 2]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (SOP SWAP)) = [INT 2; INT 1]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2; INT 5] (SOP ROT)) = [INT 2; INT 5; INT 1]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (COP EQUAL)) = [BOOL false]) ;;
assert ((Pf23.Stack.step [INT 1; INT 1] (COP EQUAL)) = [BOOL true]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (COP LT)) = [BOOL true]) ;;
assert ((Pf23.Stack.step [INT 2; INT 1] (COP LT)) = [BOOL false]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (COP GT)) = [BOOL false]) ;;

assert (
  try 
    match Pf23.Stack.step [INT 1; INT 2] IF with
    | _ -> false
  with Invalid_argument _ -> true
) ;;
assert (
  try 
    match Pf23.Stack.step [INT 1; INT 2] (MOT "CARRE") with
    | _ -> false
  with Invalid_argument _ -> true
) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (INT 3)) = [INT 3; INT 1; INT 2]) ;;
assert ((Pf23.Stack.step [] (INT 3)) = [INT 3]) ;;
assert ((Pf23.Stack.step [INT 4] (INT 10)) = [INT 10; INT 4]) ;;
assert ((Pf23.Stack.step [INT 1; INT 2] (BOOL true)) = [BOOL true; INT 1; INT 2]) ;;
assert ((Pf23.Stack.step [] (BOOL true)) = [BOOL true]) ;;