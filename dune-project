(lang dune 3.9)

(name pf23)

(generate_opam_files true)

(source
 (github baptisteauduge/interpreter-pf2023))

(authors "Baptiste Audugé")

(maintainers "Baptiste Audugé")

(license MIT with OCaml-LGPL-linking-exception)

(documentation https://github.com/baptisteauduge/interpreter-pf2023/README.md)

(package
 (name pf23)
 (synopsis "Interpreter for the PF2023 language, a PostScript-style stack language")
 (description "Interpreter for the PF2023 language, a PostScript-style stack language")
 (depends ocaml dune)
 (tags
  (interpreter, stack, postscript, pf2023, ocaml, dune)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
