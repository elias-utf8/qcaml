(**
  @author       Elias GAUTHIER
  file :        qubit.mli
  date :        2025-10-02
  license :     Apache-2.0
  description : Implementation of qubits with quantum state representation and operations.
*)

(** Type representing a qubit *)
type q

(** The qubit |0⟩ *)
val zero : q

(** The qubit |1⟩ *)
val one : q

(** Superposition |+⟩ *)
val plus: q

(** Superposition |-⟩ *)
val minus: q

(** Print the values of a qubit
    @param q The qubit to print
    @return A string representation of the qubit
*)
val print : q -> string
