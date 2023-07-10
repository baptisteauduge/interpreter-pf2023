open Elements

let fibonnaci = ": FIB DUP 1 > IF DUP 1 - FIB SWAP 2 - FIB + THEN ;"
let factorial = ": FACT DUP 1 > IF DUP 1 - FACT * THEN ;"
let square = ": SQUARE DUP * ;"
let power = ": POW SWAP DUP * SWAP 1 - DUP 1 <> IF POW THEN ;"

let default_definitions_str = fibonnaci ^ " " ^ factorial ^ " " ^ square ^ " " ^ power
let default_definitions = parse default_definitions_str
