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

open Complex

type q = {
  mutable alpha : complex;
  mutable beta : complex }

(* Cache commonly used constant *)
let sqrt2_inv = 1.0 /. sqrt 2.0

let zero ()= { alpha = Complex.one; beta = Complex.zero }

let one () = { alpha = Complex.zero; beta = Complex.one }

let plus () = {
  alpha = { re = sqrt2_inv; im = 0.0 };
  beta  = { re = sqrt2_inv; im = 0.0 };
}

let minus () = {
  alpha = { re = sqrt2_inv; im = 0.0 };
  beta  = { re = -.sqrt2_inv; im = 0.0 };
}

let get_alpha q = q.alpha

let get_beta q = q.beta

let print () q =
  Printf.sprintf "|ψ⟩ = (%.2f + %.2fi)|0⟩ + (%.2f + %.2fi)|1⟩"
    q.alpha.re q.alpha.im
    q.beta.re q.beta.im
