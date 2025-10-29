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

type complex = {
  re : float;
  im : float;
}

let zero = { re = 0.0; im = 0.0 }

let one = { re = 1.0; im = 0.0 }

let minus_one = { re = -1.0; im = 0.0 }

let cadd c1 c2 =
  { re = c1.re +. c2.re;
    im = c1.im +. c2.im }

let cmul c1 c2 =
  { re = c1.re *. c2.re -. c1.im *. c2.im;
    im = c1.re *. c2.im +. c1.im *. c2.re }

let csub c1 c2 =
  { re = c1.re -. c2.re;
    im = c1.im -. c2.im }

  let cconj c =
  { re = c.re;
    im = -. c.im }

let cmul_scalar r c =
  { re = r *. c.re;
    im = r *. c.im }

let cmod c =
  sqrt (c.re *. c.re +. c.im *. c.im)

let carg c =
  atan2 c.im c.re
