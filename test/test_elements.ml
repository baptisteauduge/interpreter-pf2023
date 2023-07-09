(* to_string *)

assert (Pf23.Elements.to_string (SOP DUP) = "DUP");;
assert (Pf23.Elements.to_string (SOP DROP) = "DROP");;
assert (Pf23.Elements.to_string (SOP SWAP) = "SWAP");;
assert (Pf23.Elements.to_string (SOP ROT) = "ROT");;
assert (Pf23.Elements.to_string (AOP ADD) = "+");;
assert (Pf23.Elements.to_string (AOP LESS) = "-");;
assert (Pf23.Elements.to_string (AOP TIMES) = "*");;
assert (Pf23.Elements.to_string (AOP DIVIDE) = "/");;
assert (Pf23.Elements.to_string (COP EQUAL) = "=");;
assert (Pf23.Elements.to_string (COP LT) = "<");;
assert (Pf23.Elements.to_string (COP GT) = ">");;
assert (Pf23.Elements.to_string (COP DIFF) = "<>");;
assert (Pf23.Elements.to_string IF = "IF");;
assert (Pf23.Elements.to_string THEN = "THEN");;
assert (Pf23.Elements.to_string ELSE = "ELSE");;
assert (Pf23.Elements.to_string (BOOL true) = "TRUE");;
assert (Pf23.Elements.to_string (BOOL false) = "FALSE");;
assert (Pf23.Elements.to_string (INT 10) = "10");;
assert (Pf23.Elements.to_string (MOT "WORD") = "WORD");;
assert (Pf23.Elements.to_string COLON = ":");;
assert (Pf23.Elements.to_string SEMICOLON = ";");;

(* to_element *)

assert (Pf23.Elements.to_element "DUP" = SOP DUP);;
assert (Pf23.Elements.to_element "DROP" = SOP DROP);;
assert (Pf23.Elements.to_element "SWAP" = SOP SWAP);;
assert (Pf23.Elements.to_element "ROT" = SOP ROT);;
assert (Pf23.Elements.to_element "+" = (AOP ADD));;
assert (Pf23.Elements.to_element "-" = (AOP LESS));;
assert (Pf23.Elements.to_element "*" = (AOP TIMES));;
assert (Pf23.Elements.to_element "/" = (AOP DIVIDE));;
assert (Pf23.Elements.to_element "=" = (COP EQUAL));;
assert (Pf23.Elements.to_element "<" = (COP LT));;
assert (Pf23.Elements.to_element ">" = (COP GT));;
assert (Pf23.Elements.to_element "<>" = (COP DIFF));;
assert (Pf23.Elements.to_element "IF" = IF);;
assert (Pf23.Elements.to_element "THEN" = THEN);;
assert (Pf23.Elements.to_element "ELSE" = ELSE);;
assert (Pf23.Elements.to_element "TRUE" = (BOOL true));;
assert (Pf23.Elements.to_element "FALSE" = (BOOL false));;
assert (Pf23.Elements.to_element "10" = (INT 10));;
assert (Pf23.Elements.to_element "WORD" = (MOT "WORD"));;
assert (Pf23.Elements.to_element ":" = COLON);;
assert (Pf23.Elements.to_element ";" = SEMICOLON);;

(* parse *)
assert (Pf23.Elements.parse "DUP" = [SOP DUP]);;
assert (Pf23.Elements.parse ": CARRE DUP * ;" = [COLON; MOT "CARRE"; SOP DUP; AOP TIMES; SEMICOLON]);;
assert (Pf23.Elements.parse ": CUBE DUP CARRE * ;" = [COLON; MOT "CUBE"; SOP DUP; MOT "CARRE"; AOP TIMES; SEMICOLON]);;
assert (Pf23.Elements.parse ": CARRE DUP * ; : CUBE DUP CARRE * ;" = [COLON; MOT "CARRE"; SOP DUP; AOP TIMES; SEMICOLON; COLON; MOT "CUBE"; SOP DUP; MOT "CARRE"; AOP TIMES; SEMICOLON]);;
assert (Pf23.Elements.parse "1 2 3" = [INT 1; INT 2; INT 3]);;
assert (Pf23.Elements.parse "1 2 3 + -" = [INT 1; INT 2; INT 3; AOP ADD; AOP LESS]);;
assert (Pf23.Elements.parse "1 2 3 + - 4 5 6" = [INT 1; INT 2; INT 3; AOP ADD; AOP LESS; INT 4; INT 5; INT 6]);;
assert (Pf23.Elements.parse ": FACTORIELLE DUP 1 > IF DUP 1 - FACTORIELLE * THEN ; 6 FACTORIELLE" = [COLON; MOT "FACTORIELLE"; SOP DUP; INT 1; COP GT; IF; SOP DUP; INT 1; AOP LESS; MOT "FACTORIELLE"; AOP TIMES; THEN; SEMICOLON; INT 6; MOT "FACTORIELLE"]);;
assert (Pf23.Elements.parse ": FACTORIELLE\nDUP 1 > IF\tDUP\r1 - FACTORIELLE *\rTHEN ;\n6 FACTORIELLE" = [COLON; MOT "FACTORIELLE"; SOP DUP; INT 1; COP GT; IF; SOP DUP; INT 1; AOP LESS; MOT "FACTORIELLE"; AOP TIMES; THEN; SEMICOLON; INT 6; MOT "FACTORIELLE"]);;

(* text *)
assert (Pf23.Elements.text [SOP DUP] = "DUP");;
assert (Pf23.Elements.text [COLON; MOT "CARRE"; SOP DUP; AOP TIMES; SEMICOLON] = ": CARRE DUP * ;");;
assert (Pf23.Elements.text [COLON; MOT "CUBE"; SOP DUP; MOT "CARRE"; AOP TIMES; SEMICOLON] = ": CUBE DUP CARRE * ;");;
assert (Pf23.Elements.text [COLON; MOT "CARRE"; SOP DUP; AOP TIMES; SEMICOLON; COLON; MOT "CUBE"; SOP DUP; MOT "CARRE"; AOP TIMES; SEMICOLON] = ": CARRE DUP * ; : CUBE DUP CARRE * ;");;
assert (Pf23.Elements.text [INT 1; INT 2; INT 3] = "1 2 3");;
assert (Pf23.Elements.text [INT 1; INT 2; INT 3; AOP ADD; AOP LESS] = "1 2 3 + -");;
assert (Pf23.Elements.text [INT 1; INT 2; INT 3; AOP ADD; AOP LESS; INT 4; INT 5; INT 6] = "1 2 3 + - 4 5 6");;
assert (Pf23.Elements.text [COLON; MOT "FACTORIELLE"; SOP DUP; INT 1; COP GT; IF; SOP DUP; INT 1; AOP LESS; MOT "FACTORIELLE"; AOP TIMES; THEN; SEMICOLON; INT 6; MOT "FACTORIELLE"] = ": FACTORIELLE DUP 1 > IF DUP 1 - FACTORIELLE * THEN ; 6 FACTORIELLE");;
