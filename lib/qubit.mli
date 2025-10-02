(**
  @file        qubit.mli
  @author      Elias GAUTHIER
  @date        2025-10-02
  @license     Apache-2.0
  @description Implementation of qubits with quantum state representation and operations.
*)

(** Type complex with real and imaginary part *)
type complex = {
  re : float;
  im : float;
}

val czero : complex

val cone : complex

(** Complex multiplication
   @param c1 First complex number
   @param c2 Second complex number
   @return The product of c1 and c2
*)
val cmul : complex -> complex -> complex
