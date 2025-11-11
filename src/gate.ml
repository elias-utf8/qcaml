(*
 * Copyright 2025 Elias GAUTHIER <elias.gauthier@etu.u-bordeaux.fr>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)
open Qubit

(* Pauli-X gate: swaps |0⟩ and |1⟩ *)
let x q =
  let new_alpha = q.beta in
  let new_beta = q.alpha in
  q.alpha <- new_alpha;
  q.beta <- new_beta

(* Cache imaginary unit constants for Y gate *)
let i = { Complex.re = 0.0; im = 1.0 }
let minus_i = { Complex.re = 0.0; im = -1.0 }

(* Pauli-Y gate *)
let y q =
  let new_alpha = Complex.cmul minus_i q.beta in
  let new_beta = Complex.cmul i q.alpha in
  q.alpha <- new_alpha;
  q.beta <- new_beta

(* Pauli-Z gate: flips phase of |1⟩ *)
let z q =
  let new_alpha = q.alpha in
  let new_beta = Complex.cmul Complex.minus_one q.beta in
  q.alpha <- new_alpha;
  q.beta <- new_beta

(* Cache sqrt(2)^-1 to avoid recomputation *)
let sqrt2_inv = 1.0 /. sqrt 2.0
let sqrt2_inv_complex = { Complex.re = sqrt2_inv; im = 0.0 }

(* Hadamard gate: creates superposition *)
let h q =
  let new_alpha = Complex.cmul sqrt2_inv_complex (Complex.cadd q.alpha q.beta) in
  let new_beta = Complex.cmul sqrt2_inv_complex (Complex.csub q.alpha q.beta) in
  q.alpha <- new_alpha;
  q.beta <- new_beta
