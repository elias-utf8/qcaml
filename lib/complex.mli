(**
  @author       Elias GAUTHIER
  file :        complex.mli
  date :        2025-10-02
  license :     Apache-2.0
  description : Implementation of complex operations.
*)

(** Type complex with real and imaginary part *)
type complex = {
  re : float;
  im : float;
}

(** Zero complex number *)
val zero : complex

(** One complex number *)
val one : complex

(** Complex multiplication
   @param c1 First complex number
   @param c2 Second complex number
   @return The product of c1 and c2
*)
val cmul : complex -> complex -> complex

(** Complex addition
   @param c1 First complex number
   @param c2 Second complex number
   @return The sum of c1 and c2
*)
val cadd : complex -> complex -> complex

(** Complex subtraction
   @param c1 First complex number
   @param c2 Second complex number
   @return The difference of c1 and c2
*)
val csub : complex -> complex -> complex

(** Complex conjugate
   @param c Complex number
   @return The conjugate of c
*)
val cconj : complex -> complex

(** Multiply complex by real scalar
   @param r Real scalar
   @param c Complex number
   @return The product of r and c
*)
val cmul_scalar : float -> complex -> complex
