(**
  @author       Elias GAUTHIER
  file :        gate.mli
  date :        2025-16-02
  license :     Apache-2.0
  description : Implementation of basic gates (Z, Y, Hadamard and Pauli gate)
*)
open Qubit

(** X gate *)
val x : q -> q

(** Z gate *)
val z : q -> q

(** Y gate *)
val y : q -> q

(** H gate *)
val h : q -> q
