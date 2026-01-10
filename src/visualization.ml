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

let rec loop angle_x angle_y =
  if Raylib.window_should_close () then Raylib.close_window ()
  else
    let open Raylib in
    
    let new_angle_x, new_angle_y =
      if is_mouse_button_down MouseButton.Left then
        let delta = get_mouse_delta () in
        (angle_x +. Vector2.y delta *. 0.01, angle_y +. Vector2.x delta *. 0.01)
      else
        (angle_x, angle_y)
    in
    
    let radius = 4.0 in
    let cam_x = radius *. cos new_angle_y *. cos new_angle_x in
    let cam_z = radius *. sin new_angle_x in
    let cam_y = radius *. sin new_angle_y *. cos new_angle_x in
    
    let camera = Camera3D.create
      (Vector3.create cam_x cam_y cam_z)
      (Vector3.create 0.0 0.0 0.0)
      (Vector3.create 0.0 0.0 1.0)
      45.0
      CameraProjection.Perspective
    in
    
    begin_drawing ();
    clear_background Color.raywhite;
    begin_mode_3d camera;
    
    draw_sphere_wires (Vector3.create 0.0 0.0 0.0) 1.0 15 15 (Color.create 220 220 220 255);
    
    for i = 0 to 2 do
      let offset = float_of_int i *. 0.003 in
      draw_circle_3d (Vector3.create 0.0 0.0 0.0) (1.0 +. offset) (Vector3.create 1.0 0.0 0.0) 90.0 Color.darkgray;
      draw_circle_3d (Vector3.create 0.0 0.0 0.0) (1.0 +. offset) (Vector3.create 0.0 1.0 0.0) 90.0 Color.darkgray;
      draw_circle_3d (Vector3.create 0.0 0.0 0.0) (1.0 +. offset) (Vector3.create 0.0 0.0 1.0) 90.0 Color.darkgray;
    done;
    
    draw_cylinder_ex (Vector3.create (-1.0) 0.0 0.0) (Vector3.create 1.0 0.0 0.0) 0.01 0.005 8 Color.black;
    draw_cylinder_ex (Vector3.create 0.0 (-1.0) 0.0) (Vector3.create 0.0 1.0 0.0) 0.01 0.005 8 Color.black;
    draw_cylinder_ex (Vector3.create 0.0 0.0 (-1.0)) (Vector3.create 0.0 0.0 1.0) 0.01 0.005 8 Color.black;
    
    end_mode_3d ();
    
    let x_pos = get_world_to_screen (Vector3.create 1.1 0.0 0.0) camera in
    let y_pos = get_world_to_screen (Vector3.create 0.0 1.1 0.0) camera in
    let z_pos = get_world_to_screen (Vector3.create 0.0 0.0 1.1) camera in
    let z_neg_pos = get_world_to_screen (Vector3.create 0.0 0.0 (-1.1)) camera in
    draw_text "X" (Vector2.x x_pos |> int_of_float) (Vector2.y x_pos |> int_of_float) 20 Color.red;
    draw_text "Y" (Vector2.x y_pos |> int_of_float) (Vector2.y y_pos |> int_of_float) 20 Color.green;
    
    draw_text "|0>" (Vector2.x z_pos |> int_of_float) ((Vector2.y z_pos |> int_of_float) - 20) 24 Color.black;
    draw_text "|1>" (Vector2.x z_neg_pos |> int_of_float) ((Vector2.y z_neg_pos |> int_of_float) + 5) 24 Color.black;
    
    end_drawing ();
    loop new_angle_x new_angle_y

let plot_bloch () =
  Raylib.init_window 600 600 "qcaml";
  Raylib.set_target_fps 60;
  loop 0.5 0.8