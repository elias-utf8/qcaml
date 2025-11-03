# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3](https://github.com/elias-utf8/qcaml/releases/tag/v0.1.3) - 2025-11-2
### Added 
- Update dune version lower bound to 3.17

## [0.1.2](https://github.com/elias-utf8/qcaml/releases/tag/v0.1.2) - 2025-11-2
### Added 
- Nothing

### Fixed
- Fixed a critical build failure on Windows/MinGW platforms caused by platform-specific OpenGL library naming differences.

## [0.1.1](https://github.com/elias-utf8/qcaml/releases/tag/v0.1.1) - 2025-11-1

### Added 
- Nothing

### Fixed
- Y gate test
- Type error in apply_gate.ml line 8 - Qubit.print () q returns string but Printf.printf expects a format string

## [0.1.0] - 2025-10-29

### Added
- Initial public release
- Single qubit state representation with complex amplitudes
- Qubit state constructors: `zero()`, `one()`, `plus()`, `minus()`
- Pauli gates: X, Y, Z
- Hadamard gate (H)
- Quantum measurement with probabilistic collapse
- Interactive Bloch sphere visualization using OpenGL/GLUT
- Complex number module with arithmetic operations
- Comprehensive test suite using Alcotest
- Example programs demonstrating library usage
- Apache 2.0 license

### Known Limitations
- Single-qubit operations only (no multi-qubit support)
- Limited gate set
- No circuit builder API yet
- Bloch sphere visualization can be a little buggy

## [Unreleased]

### Later
- Phase gate (S)
- Rotation gates (Rx, Ry, Rz)
- Multi-qubit systems with tensor products
- Entangling gates (CNOT, Toffoli, SWAP)
- Circuit builder API
- QASM export functionality

---

[0.1.0]: https://github.com/elias-utf8/qcaml/releases/tag/v0.1.0
