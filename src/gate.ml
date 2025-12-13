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

let x q =
  let new_alpha = Complex.cadd
    (Complex.cmul Complex.zero q.alpha)
    (Complex.cmul Complex.one q.beta) in
  let new_beta = Complex.cadd
    (Complex.cmul Complex.one q.alpha)
    (Complex.cmul Complex.zero q.beta) in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let y q =
  let i = { Complex.re = 0.0; im = 1.0 } in
  let minus_i = { Complex.re = 0.0; im = -1.0 } in
  let new_alpha = Complex.cmul minus_i q.beta in
  let new_beta = Complex.cmul i q.alpha in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let z q =
  let new_alpha = Complex.cadd
    (Complex.cmul Complex.one q.alpha)
    (Complex.cmul Complex.zero q.beta) in
  let new_beta = Complex.cadd
    (Complex.cmul Complex.zero q.alpha)
    (Complex.cmul Complex.minus_one q.beta) in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let h q =
  let sqrt2_inv = 1.0 /. sqrt 2.0 in
  let factor = { Complex.re = sqrt2_inv; im = 0.0 } in
  let new_alpha = Complex.cmul factor (Complex.cadd q.alpha q.beta) in
  let new_beta = Complex.cmul factor (Complex.csub q.alpha q.beta) in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let s q =
  let i = { Complex.re = 0.0; im = 1.0 } in
  let new_alpha = Complex.cmul Complex.one q.alpha in
  let new_beta = Complex.cmul i q.beta in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let t q =
  let exp_i_pi_4 = { Complex.re = sqrt 2.0 /. 2.0; im = sqrt 2.0 /. 2.0 } in
  let new_alpha = Complex.cmul Complex.one q.alpha in
  let new_beta = Complex.cmul exp_i_pi_4 q.beta in
  q.alpha <- new_alpha;
  q.beta <- new_beta