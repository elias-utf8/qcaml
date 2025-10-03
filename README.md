<div align="center">
   <img src="https://github.com/elias-utf8/qcaml/blob/main/docs/images/qcaml_banner.png" alt="QCaml logo" width="350"/>
   
   Experimental ocaml library for quantum computing
   
   [![License](https://img.shields.io/badge/License-Apache%202.0-3c60b1.svg?logo=opensourceinitiative&logoColor=white&style=flat-square)](https://github.com/elias-utf8/qcaml/blob/main/LICENSE)
   [![OCaml](https://img.shields.io/badge/OCaml-5.2-ec6813.svg?style=flat-square&logo=ocaml&logoColor=white)](https://ocaml.org/)
   
</div>

## Presentation
QCaml for Quantum (O)Caml is an experimental library for simulating quantum algorithms. This library is currently under development. Among the MVP's features are qubit declaration, application of classical gates (H, X, CNOT), measurement, and visualization.

## Features

## Installation 
### Prerequisites
You need the [opam](https://opam.ocaml.org/) package manager to install the OCaml build tools.
```sh
$ sudo apt install opam   # debian/ubuntu
$ opam init
$ opam switch create 5.2.0
$ eval $(opam env)
$ opam install dune odoc
```
### Build
The following will clone the repository, build QCaml and install it into your opam.
```sh
$ git clone https://github.com/elias-utf8/qcaml.git
$ cd qcaml/
$ opam install .
$ dune build @doc # for local documentation (optional)
```

## Usages

## Documentation
To read the project whole documentation, please refer to the [wiki](https://github.com/elias-utf8/qcaml/wiki).
