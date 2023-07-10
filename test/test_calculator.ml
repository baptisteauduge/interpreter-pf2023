(* calc *)
assert ((Pf23.Calculator.calc [] [INT 1; INT 2; AOP ADD]) = [INT 3]) ;;
assert ((Pf23.Calculator.calc [] [INT 1; INT 2; AOP LESS]) = [INT (-1)]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; AOP TIMES]) = [INT 20]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; SOP DUP; AOP TIMES]) = [INT 100]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; AOP DIVIDE]) = [INT 5]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; AOP LESS]) = [INT 8]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; SOP SWAP; AOP LESS]) = [INT (-8)]) ;;
assert ((Pf23.Calculator.calc [] [INT 15; INT 5; SOP DUP; SOP DROP; AOP LESS]) = [INT 10]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; AOP LESS; INT 3; AOP TIMES]) = [INT 24]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 3; COP EQUAL]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP LT]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP GT]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP EQUAL]) = [BOOL true]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP DIFF]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [BOOL true; INT 2; INT 2; COP DIFF]) = [BOOL false; BOOL true]) ;;
assert ((Pf23.Calculator.calc [] []) = []) ;;