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

type sphere_values = {
  phi : float;
  theta : float;
  alpha_re : float;
  alpha_im : float;
  beta_re : float;
  beta_im : float;
}

let get_values q =
  let phi = (carg q.beta) -. (carg q.alpha) in
  let theta = 2.0 *. acos (cmod q.alpha) in
  let alpha_re = q.alpha.re in
  let alpha_im = q.alpha.im in
  let beta_re = q.beta.re in
  let beta_im = q.beta.im in
  { phi; theta; alpha_re; alpha_im; beta_re; beta_im }

let rec loop camera =
  if Raylib.window_should_close () then Raylib.close_window ()
  else
    let open Raylib in
    begin_drawing ();
    clear_background Color.raywhite;
    begin_mode_3d camera;
    
    (* Sphère de Bloch en fil de fer *)
    draw_sphere_wires (Vector3.create 0.0 0.0 0.0) 1.0 15 15 Color.gray;
    
    (* Axes X, Y, Z *)
    draw_line_3d (Vector3.create (-1.2) 0.0 0.0) (Vector3.create 1.2 0.0 0.0) Color.red;
    draw_line_3d (Vector3.create 0.0 (-1.2) 0.0) (Vector3.create 0.0 1.2 0.0) Color.green;
    draw_line_3d (Vector3.create 0.0 0.0 (-1.2)) (Vector3.create 0.0 0.0 1.2) Color.darkblue;
    
    end_mode_3d ();
    
    (* Labels des axes en convertissant les positions 3D en 2D *)
    let x_pos = get_world_to_screen (Vector3.create 1.3 0.0 0.0) camera in
    let y_pos = get_world_to_screen (Vector3.create 0.0 1.3 0.0) camera in
    let z_pos = get_world_to_screen (Vector3.create 0.0 0.0 1.3) camera in
    draw_text "X" (Vector2.x x_pos |> int_of_float) (Vector2.y x_pos |> int_of_float) 20 Color.red;
    draw_text "Y" (Vector2.x y_pos |> int_of_float) (Vector2.y y_pos |> int_of_float) 20 Color.green;
    draw_text "Z" (Vector2.x z_pos |> int_of_float) (Vector2.y z_pos |> int_of_float) 20 Color.darkblue;
    
    (* Labels *)
    draw_text "Bloch Sphere" 10 10 20 Color.darkgray;
    draw_text "X: Red | Y: Green | Z: Blue" 10 35 15 Color.darkgray;
    
    end_drawing ();
    loop camera

let plot_bloch () =
  Raylib.init_window 600 600 "Bloch Sphere Visualization";
  Raylib.set_target_fps 60;
  let camera = Raylib.Camera3D.create
    (Raylib.Vector3.create 2.5 2.5 2.5)    (* position *)
    (Raylib.Vector3.create 0.0 0.0 0.0)    (* target *)
    (Raylib.Vector3.create 0.0 1.0 0.0)    (* up *)
    45.0                                     (* fovy *)
    Raylib.CameraProjection.Perspective     (* projection *)
  in
  loop camera


