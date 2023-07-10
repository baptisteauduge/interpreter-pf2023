type stack_elements =
  | INT of int
  | BOOL of bool

type stack = stack_elements list
let empty_stack_error: string = "Empty stack"

let push (s: stack) (value: stack_elements) =
  value::s

let pop (s: stack) =
  match s with
  | [] -> failwith empty_stack_error
  | x::xs -> (x, xs)

let top (s: stack): stack_elements =
  match s with
  | [] -> failwith empty_stack_error
  | x::_ -> x

let eval_cop (s: stack) (op: Elements.compare_operators) =
  let eval_cop_aux (s: stack) (op: int -> int -> bool): stack =
    match pop s with
    | (INT val1, s) ->
      begin
        match pop s with
        | (INT val2, s) -> (BOOL (op val2 val1))::s
        | _ -> invalid_arg "eval_stack_cop"
      end
    | _ -> invalid_arg "eval_stack_cop"
  in

  match op with
  | EQUAL -> eval_cop_aux s (=)
  | LT -> eval_cop_aux s (<)
  | GT -> eval_cop_aux s (>)
  | DIFF -> eval_cop_aux s (<>)

let eval_aop (s: stack) (op: Elements.arithmetic_operators): stack =
  let eval_aop_aux (s: stack) (op: int -> int -> int): stack =
    match pop s with
    | (INT val1, s) ->
      begin
        match pop s with
        | (INT val2, s) -> (INT (op val2 val1))::s
        | _ -> invalid_arg "eval_stack_aop"
      end
    | _ -> invalid_arg "eval_stack_aop"
  in

  match op with
  | ADD -> eval_aop_aux s (+)
  | LESS -> eval_aop_aux s (-)
  | TIMES -> eval_aop_aux s ( * )
  | DIVIDE -> eval_aop_aux s (/)

let eval_sop (s: stack) (op: Elements.stack_operators) =
  let drop (s: stack) =
    match pop s with
    | (_, s) -> s
    in
  
  let swap (s: stack) =
    match pop s with
    | (val1, s) ->
      match pop s with
      | (val2, s) -> val2::val1::s
    in

  let rot (s: stack) =
    match pop s with
    | (val1, s) ->
      match pop s with
      | (val2, s) ->
        match pop s with
        | (val3, s) -> val2::val3::val1::s
    in

  match op with
  | DUP -> push s (top s)
  | DROP -> drop s
  | SWAP -> swap s
  | ROT -> rot s

let step (s: stack) (value: Elements.element): stack =
  match value with
  | INT i -> push s (INT i)
  | BOOL b -> push s (BOOL b)
  | AOP op -> eval_aop s op
  | COP op -> eval_cop s op
  | SOP op -> eval_sop s op
  | _ -> invalid_arg "step"