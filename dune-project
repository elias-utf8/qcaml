(lang dune 2.9)
(name qcaml)
(version 0.1.1)
(use_standard_c_and_cxx_flags false)
(generate_opam_files true)

(source (github elias-utf8/qcaml))
(license Apache-2.0)
(authors "Elias GAUTHIER")
(maintainers "elias.gauthier@etu.u-bordeaux.fr")

(documentation "https://elias-utf8.github.io/qcaml/")

(package
 (name qcaml)
 (synopsis "Experimental OCaml library for quantum computing simulation")
 (description "\
QCaml is a lightweight OCaml library for experimenting with quantum states,
gates and measurements. It provides tools for learning quantum computing
concepts and visualizing qubit states on the Bloch sphere.

Features:
- Single qubit state representation with complex amplitudes
- Fundamental quantum gates (Hadamard, Pauli-X/Y/Z)
- Quantum measurements with probabilistic state collapse
- Interactive Bloch sphere visualization using OpenGL/GLUT
- Comprehensive test suite")
 (depends
  (ocaml (>= 5.2))
  (dune (>= 2.9))
  dune-configurator
  conf-freeglut
  (alcotest :with-test)
  (odoc :with-doc)
  (bisect_ppx :with-test))
 (tags
  (quantum computing simulation qubits gates visualization bloch-sphere)))
