(* add *)
open Pf23.Dict ;;
open Pf23.Elements ;;
assert ((add "" [] []) = []) ;;
assert ((add "a" [] []) = [Letter ('a', Some [], [])]) ;;
assert ((add "ab" [] []) = [Letter ('a', None, [Letter ('b', Some [], [])])])
let prog1 = [INT 1; INT 2; AOP ADD] ;;
let dict1 = [Letter ('a', None, [Letter ('b', Some prog1, [])])] ;;
assert ((add "ab" prog1 []) = dict1) ;;
let prog2 = [INT 3; INT 4; AOP ADD] ;;
assert ((add "ef" prog2 dict1) = [Letter ('a', None, [Letter ('b', Some prog1, [])]); Letter('e', None, [Letter('f', Some prog2, [])])]) ;;
(* On vérifie que l'on écrase bien l'ancien programme *)
assert ((add "ab" prog2 dict1) = [Letter ('a', None, [Letter ('b', Some prog2, [])])]) ;;

(* lookup *)
assert ((lookup "ab" dict1) = prog1) ;;
assert ((lookup "ab" [Letter ('a', None, [Letter ('b', Some prog2, [])])]) = prog2) ;;
assert ((lookup "ab" empty_name_dict_program) = []) ;;
assert ((lookup "ef" [Letter ('a', None, [Letter ('b', Some prog1, [])]); Letter('e', None, [Letter('f', Some prog2, [])])]) = prog2) ;;
assert ((lookup "ef" dict1) = []) ;;
assert ((lookup "e" [Letter ('a', None, [Letter ('b', Some prog1, [])]); Letter('e', None, [Letter('f', Some prog2, [])])]) = []) ;;
