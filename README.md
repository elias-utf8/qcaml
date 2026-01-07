# <img src="https://github.com/elias-utf8/qcaml/blob/main/assets/images/qcaml_banner.png" alt="QCaml logo" width="250"/>

A lightweight OCaml library to experiment with quantum states, gates and measurements. For learning quantum computing concepts and visualizing qubit states on the Bloch sphere.

[![License](https://img.shields.io/badge/License-Apache%202.0-3c60b1.svg?logo=opensourceinitiative&logoColor=white&style=flat-square)](https://github.com/elias-utf8/qcaml/blob/main/LICENSE)
[![OCaml](https://img.shields.io/badge/OCaml-5.2-ec6813.svg?style=flat-square&logo=ocaml&logoColor=white)](https://ocaml.org/)
[![CI Status](https://img.shields.io/github/actions/workflow/status/elias-utf8/qcaml/main.yml?style=flat-square&logo=github&label=build)](https://github.com/elias-utf8/qcaml/actions/workflows/pages.yml)

## Presentation <img src="https://github.com/elias-utf8/qcaml/blob/main/assets/images/code_snippet.png" width="400px" align="right">

QCaml for Quantum (O)Caml is an experimental library for simulating quantum algorithms. This library is currently under development. Among the MVP's features are qubit declaration, application of classical gates (X,Y,Z,H), measurement, and visualization.
> [!IMPORTANT]
>
> **Status**: This library is currently in early development and may change significantly.
>
<br>

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
### Install from OPAM (recommended)
QCaml is now available on the official OPAM repository, so you can install it directly:
```sh
$ opam install qcaml
```
### Develop locally
If you want to work on QCaml locally (for development, testing, or contributing), you can still clone and build the repository manually.

The following will clone the repository, build QCaml and install it into your opam.
```sh
$ git clone https://github.com/elias-utf8/qcaml.git
$ cd qcaml/
$ make
$ opam install .
```

## Quick start
Try this simple example by running `dune exec examples/bloch_sphere.exe` to visualize a superposition state on the Bloch sphere:

<table>
<tr>
<td>

```ocaml
(* examples/bloch_sphere.ml *)
open Quantum

let () =
  let q = Qubit.plus () in
  Visualization.plot_bloch q;
  Measurement.measure q;
  Printf.printf "%s\n" (Qubit.print () q);
```
</td>
<td>
  <img src="https://github.com/elias-utf8/qcaml/blob/main/assets/images/bloch.png" alt="Bloch Sphere" width="400">
</td>
</tr>
</table>

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
      <td><span>✓ Completed</span></td>
      <td>Implementation of fundamental gates (Hadamard, Pauli-X/Y/Z)</td>
    </tr>
    <tr>
      <td><strong>Quantum Measurements</strong></td>
      <td><span style="color: #6c757d;">✓ Completed</span></td>
      <td>Computational basis measurements with probability calculations</td>
    </tr>
    <tr>
    <tr>
      <td><strong>Bloch sphere visualization</strong></td>
      <td><span>✓ Completed</span></td>
      <td>Visualization of qubit states on the Bloch sphere</td>
    </tr>
    <tr>
      <td><strong>Advanced Gate</strong></td>
      <td><span>In progress..</span></td>
      <td>Extended gate set (Phase and rotation gates)</td>
    </tr>
    <tr>
      <td><strong>Circuit Builder</strong></td>
      <td><span>○ Planned</span></td>
      <td>High-level API for composing and optimizing quantum circuits</td>
    </tr>
    <tr>
      <td><strong>Multi-Qubit Operations</strong></td>
      <td><span>○ Planned</span></td>
      <td>Efficient tensor product operations for n-qubit systems</td>
    </tr>
    <tr>
      <td><strong>Simulator</strong></td>
      <td><span>○ Planned (I will never have time)</span></td>
      <td>Export circuits to standard formats (QASM, diagram generation)</td>
    </tr>
  </tbody>
</table>

## Documentation
<p>

   API Reference: Generated documentation at `_build/default/_doc/_html/index.html` (after running dune build @doc) or see [online documentation](https://elias-utf8.github.io/qcaml/) )
</p>

## Resources
**Quantum Computing Course – Math and Theory for Beginners :** https://youtu.be/tsbCSkvHhMo?si=XTbz10_b1v1aAS-3
