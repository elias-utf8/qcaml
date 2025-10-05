(lang dune 2.9)
(name qcaml)
(version 0.1.0)

(generate_opam_files true)

(source (github elias-utf8/qcaml))
(license Apache-2.0)
(authors "Elias GAUTHIER")
(maintainers "elias.gauthier@etu.u-bordeaux.fr")

(package
 (name qcaml)
 (synopsis "QCaml is an experimental ocaml library for quantum computing.")
 (description "Simulation of quantum circuits with qubits, gates, and measurements")
 (depends
  (ocaml (>= 5.2))
  dune
  (alcotest :with-test)))
