(**
  @file        qubit.mli
  @author      Elias GAUTHIER
  @date        2025-10-02
  @license     Apache-2.0
  @description Implementation of qubits with quantum state representation and operations.
*)

type complex = {
  re : float;
  im : float;
}

val czero : complex

val cone : complex
