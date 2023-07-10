# PF23 - A PostScript-style stack language

PF23 is a stack-based language inspired by PostScript. It is designed to be simple, easy to implement, and easy to use.

## Language

PF23 is working with a Stack, which is a LIFO (Last In First Out) data structure. The stack is composed of values, which can be boolean or integers. The stack is initialized with an empty stack.

## Program structure

A PF23 program is a sequence of operators, functions call, if/else statements. Each element is, followed by a space, a tabulation or a new line. The arguments are pushed on the stack before the instruction is executed. The instruction is executed, and the result is pushed on the stack.

## Operators, functions and conditions

### Arithmetic operators

| Operator | Description | Stack before | Stack after |
| --- | --- | --- | --- |
| `+` | Addition | `a b` | `a+b` |
| `-` | Substraction | `a b` | `a-b` |
| `*` | Multiplication | `a b` | `a*b` |
| `/` | Division | `a b` | `a/b` |

### Comparison operators

| Operator | Description | Stack before | Stack after |
| --- | --- | --- | --- |
| `=` | Equality | `a b` | `a=b` |
| `<>` | Inequality | `a b` | `a!=b` |
| `<` | Less than | `a b` | `a<b` |
| `>` | Greater than | `a b` | `a>b` |

### Stack operators

| Operator | Description | Stack before | Stack after |
| --- | --- | --- | --- |
| `DUP` | Duplicate the top of the stack | `a` | `a a` |
| `DROP` | Remove the top of the stack | `a` | |
| `SWAP` | Swap the two top elements of the stack | `a b` | `b a` |
| `ROT` | Rotate the three top elements of the stack | `a b c` | `b c a` |

### Conditions

| Operator | Description | Stack before | Stack after |
| --- | --- | --- | --- |
| `IF` | If the top of the stack is true, execute the next instruction | `a` | |
| `THEN` | End of an if statement | | |
| `ELSE` | If the top of the stack is false, execute the next instruction | `a` | |
| `ENDIF` | End of an if/else statement | | |

***Some examples of if/else statements:***

In this example, if 1 = 2 is true, 10 is pushed on the stack. Else, 0 is pushed on the stack.
And in every case, 100 is pushed on the stack.

```
1 2 = IF
    10
ELSE
    0
ENDIF
100
```

We will have the following result:

```
0
100

```

In this example, if 1 = 2 is true, 10 is pushed on the stack. Else, nothing is pushed on the stack.
And in every case, 100 is pushed on the stack.

```
1 2 = IF
    10
THEN
    100
```

We will have the following result:

```
100
```

### Functions

| Operator | Description |
| --- | --- |
| `: NAME` | Beginning of the definition of a function called `NAME` |
| `;` | End of the definition of a function |

***Some examples of functions:***

```
: ADD1
    1 +
;
```

```
: FIB 
  DUP 1 > IF 
    DUP 1 - FIB SWAP 2 - FIB + 
  THEN 
;
```

> :warning: A function can't be defined inside another function. 

The following code is not valid:

```
: FIB 
  : ADD1
    1 +
  ;
  DUP 1 > IF 
    DUP 1 - FIB SWAP 2 - FIB + 
  THEN
;
```

## Interpreter

The interpreter is a program written in OCaml that reads a PF23 program and executes it.
You can quit it by typing `quit` on a new line.
You can also use the function `list func` to list all the functions defined in the program.

### Compilation / Installation

This program is written in OCaml, using the `dune` build system. You can compile it by typing `dune build` in the root directory of the project.
The executable will be compiled into a binary file called `main.bc` and a native file called `main.exe`.
You will find them in the `_build/default/bin` directory.

