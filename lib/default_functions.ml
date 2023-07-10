let fibonnaci = ": FIB DUP 1 > IF DUP 1 - FIB SWAP 2 - FIB + THEN ;"
let factorial = ": FACT DUP 1 > IF DUP 1 - FACT * THEN ;"
let square = ": SQUARE DUP * ;"
(* USAGE: "10 3 POW" *)
let power = ": POW SWAP DUP * SWAP 1 - DUP 1 <> IF POW THEN ; 10  POW"

let a = ": A 
            : B 3 ADD ; 
            2 ADD"