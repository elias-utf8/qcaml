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
open Complex

external bloch : float -> float -> float -> float -> float -> float -> unit = "bloch_bytecode" "bloch_native"

let plot_bloch q =
  flush stdout;
  let phi = (carg q.beta) -. (carg q.alpha) in
  let theta = 2.0 *. acos (cmod q.alpha) in
  let alpha_re = q.alpha.re in
  let alpha_im = q.alpha.im in
  let beta_re = q.beta.re in
  let beta_im = q.beta.im in
  bloch phi theta alpha_re alpha_im beta_re beta_im
