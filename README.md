<div align="center">
   <img src="https://github.com/elias-utf8/qcaml/blob/main/assets/images/qcaml_banner.png" alt="QCaml logo" width="350"/>

   A lightweight OCaml library for exploring quantum algorithms and circuits

   [![License](https://img.shields.io/badge/License-Apache%202.0-3c60b1.svg?logo=opensourceinitiative&logoColor=white&style=flat-square)](https://github.com/elias-utf8/qcaml/blob/main/LICENSE)
   [![OCaml](https://img.shields.io/badge/OCaml-5.2-ec6813.svg?style=flat-square&logo=ocaml&logoColor=white)](https://ocaml.org/)
   [![CI Status](https://img.shields.io/github/actions/workflow/status/elias-utf8/qcaml/main.yml?style=flat-square&logo=github&label=build)](https://github.com/elias-utf8/qcaml/actions/workflows/main.yml)
</div>

## Presentation
QCaml for Quantum (O)Caml is an experimental library for simulating quantum algorithms. This library is currently under development. Among the MVP's features are qubit declaration, application of classical gates (H, X, CNOT), measurement, and visualization.

**Status**: This library is currently in early development and the API may change significantly.

## Installation
### Prerequisites
You need the [opam](https://opam.ocaml.org/) package manager to install the OCaml build tools.
```sh
$ sudo apt install opam   # debian/ubuntu
$ opam init
$ opam switch create 5.2.0
$ eval $(opam env)
$ opam install dune odoc alcotest bisect_ppx
```
### Build and install
The following will clone the repository, build QCaml and install it into your opam.
```sh
$ git clone https://github.com/elias-utf8/qcaml.git
$ cd qcaml/
$ opam install .
$ make build          # build the project
$ make test           # run tests (optional)
$ make coverage       # run tests with coverage report (optional)
$ make doc	          # for local documentation (optional)
```

## Quick start
## Usages examples
## Features
<table>
  <thead>
    <tr>
      <th width="35%">Feature</th>
      <th width="20%">Status</th>
      <th width="45%">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Qubit Initialization</strong></td>
      <td><span>✓ Completed</span></td>
      <td>Single and multi-qubit state initialization with arbitrary amplitudes</td>
    </tr>
    <tr>
      <td><strong>Basic Quantum Gates</strong></td>
      <td><span>⚠ In Progress</span></td>
      <td>Implementation of fundamental gates (Hadamard, Pauli-X/Y/Z)</td>
    </tr>
    <tr>
      <td><strong>Quantum Measurements</strong></td>
      <td><span style="color: #6c757d;">○ Planned</span></td>
      <td>Computational basis measurements with probability calculations</td>
    </tr>
    <tr>
      <td><strong>Advanced Gate</strong></td>
      <td><span>○ Planned</span></td>
      <td>Extended gate set (Phase, CNOT, Toffoli, SWAP, controlled gates, rotation gates)</td>
    </tr>
    <tr>
      <td><strong>Multi-Qubit Operations</strong></td>
      <td><span>○ Planned</span></td>
      <td>Efficient tensor product operations for n-qubit systems</td>
    </tr>
    <tr>
      <td><strong>Circuit Builder</strong></td>
      <td><span>○ Planned</span></td>
      <td>High-level API for composing and optimizing quantum circuits</td>
    </tr>
    <tr>
      <td><strong>Circuit Visualization</strong></td>
      <td><span>○ Planned</span></td>
      <td>Export circuits to standard formats (QASM, diagram generation)</td>
    </tr>
  </tbody>
</table>

## Documentation

<p>

   To read the project whole documentation, please refer to the [wiki](https://github.com/elias-utf8/qcaml/wiki).
</p>
<p>

   API Reference: Generated documentation at `_build/default/_doc/_html/index.html` (after running dune build @doc) or see [online documentation](https://elias-utf8.github.io/qcaml/) )
</p>
