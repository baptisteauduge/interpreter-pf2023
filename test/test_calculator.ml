(* calc *)
assert ((Pf23.Calculator.calc [] [INT 1; INT 2; AOP PLUS]) = [INT 3]) ;;
assert ((Pf23.Calculator.calc [] [INT 1; INT 2; AOP MINUS]) = [INT (1)]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; AOP TIMES]) = [INT 20]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; SOP DUP; AOP TIMES]) = [INT 100]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 10; AOP DIVIDE]) = [INT 5]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; AOP MINUS]) = [INT (-8)]) ;;
assert ((Pf23.Calculator.calc [] [INT 10; INT 2; SOP SWAP; AOP MINUS]) = [INT 8]) ;;
assert ((Pf23.Calculator.calc [] [INT 15; INT 5; SOP DUP; SOP DROP; AOP MINUS]) = [INT (-10)]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 10; AOP MINUS; INT 3; AOP TIMES]) = [INT 24]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 3; COP EQUAL]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP LT]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP GT]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP EQUAL]) = [BOOL true]) ;;
assert ((Pf23.Calculator.calc [] [INT 2; INT 2; COP DIFF]) = [BOOL false]) ;;
assert ((Pf23.Calculator.calc [] [BOOL true; INT 2; INT 2; COP DIFF]) = [BOOL false; BOOL true]) ;;
