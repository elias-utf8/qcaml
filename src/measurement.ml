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

let measure q =
  let p0 = cmod q.alpha *. cmod q.alpha in  (* Probability of |0⟩ *)

  let rand = Random.float 1.0 in
  if rand < p0 then begin
    (* Collapse to |0⟩ *)
    q.alpha <- Complex.one;
    q.beta <- Complex.zero;
  end else begin
    (* Collapse to |1⟩ *)
    q.alpha <- Complex.zero;
    q.beta <- Complex.one;
  end
