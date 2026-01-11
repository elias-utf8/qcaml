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

let get_cartesian_coordinates q =
  let values = get_values q in
  let x = sin values.theta *. cos values.phi in
  let y = sin values.theta *. sin values.phi in
  let z = cos values.theta in
  (x, y, z)

let current_qubit : q option ref = ref None

let rec loop angle_x angle_y font =
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

    (* Get current window dimensions for responsive camera *)
    let window_width = float_of_int (get_screen_width ()) in
    let window_height = float_of_int (get_screen_height ()) in
    let aspect_ratio = window_width /. window_height in
    
    (* Adjust FOV based on aspect ratio to maintain sphere proportions *)
    let fov = if aspect_ratio > 1.0 then 30.0 else 30.0 /. aspect_ratio in

    let radius = 5.0 in
    let cam_x = radius *. cos new_angle_y *. cos new_angle_x in
    let cam_z = radius *. sin new_angle_x in
    let cam_y = radius *. sin new_angle_y *. cos new_angle_x in

    let camera = Camera3D.create
      (Vector3.create cam_x cam_y cam_z)
      (Vector3.create 0.0 0.0 0.0)
      (Vector3.create 0.0 0.0 1.0)
      fov
      CameraProjection.Perspective
    in

    begin_drawing ();
    clear_background Color.raywhite;
    begin_mode_3d camera;
    
    for lat = 1 to 11 do
      let angle = (float_of_int lat) *. Float.pi /. 12.0 in
      let r = sin angle in
      let z = cos angle in
      for i = 0 to 2 do
        let offset = (float_of_int i) *. 0.002 in
        draw_circle_3d (Vector3.create 0.0 0.0 z) (r +. offset) (Vector3.create 0.0 0.0 1.0) 0.0 (Color.create 190 190 190 255);
      done;
    done;

    for lon = 1 to 5 do
      let angle = (float_of_int lon) *. Float.pi /. 6.0 in
      let nx = sin angle in
      let ny = cos angle in
      for i = 0 to 2 do
        let offset = (float_of_int i) *. 0.002 in
        draw_circle_3d (Vector3.create 0.0 0.0 0.0) (1.0 +. offset) (Vector3.create nx ny 0.0) 90.0 (Color.create 190 190 190 255);
      done;
    done;
    
    for i = 0 to 3 do
      let offset = float_of_int i *. 0.0025 in
      draw_circle_3d (Vector3.create 0.0 0.0 0.0) (1.0 +. offset) (Vector3.create 1.0 0.0 0.0) 90.0 Color.black;
      draw_circle_3d (Vector3.create 0.0 0.0 0.0) (1.0 +. offset) (Vector3.create 0.0 0.0 1.0) 90.0 Color.black;
    done;

    (match !current_qubit with
    | Some q -> 
        let (x, y, z) = get_cartesian_coordinates q in
        draw_sphere (Vector3.create x y z) 0.03 Color.orange;
    | None -> ());
    
    draw_cylinder_ex (Vector3.create (-1.0) 0.0 0.0) (Vector3.create 1.0 0.0 0.0) 0.01 0.005 8 Color.black;
    draw_cylinder_ex (Vector3.create 0.0 (-1.0) 0.0) (Vector3.create 0.0 1.0 0.0) 0.01 0.005 8 Color.black;
    draw_cylinder_ex (Vector3.create 0.0 0.0 (-1.0)) (Vector3.create 0.0 0.0 1.0) 0.01 0.005 8 Color.black;
    
    draw_sphere (Vector3.create 0.0 0.0 0.0) 1.0 (Color.create 200 160 255 50);
    
    end_mode_3d ();
    
    let x_pos = get_world_to_screen (Vector3.create 1.1 0.0 0.0) camera in
    let y_pos = get_world_to_screen (Vector3.create 0.0 1.1 0.0) camera in
    let z_pos = get_world_to_screen (Vector3.create 0.0 0.0 1.1) camera in
    let z_neg_pos = get_world_to_screen (Vector3.create 0.0 0.0 (-1.1)) camera in
    
    draw_text_ex font "X" (Vector2.create (Vector2.x x_pos) (Vector2.y x_pos)) 20.0 1.0 Color.black;
    draw_text_ex font "Y" (Vector2.create (Vector2.x y_pos) (Vector2.y y_pos)) 20.0 1.0 Color.black;
    
    draw_text_ex font "|0>" (Vector2.create (Vector2.x z_pos) (Vector2.y z_pos -. 20.0)) 24.0 1.0 Color.black;
    draw_text_ex font "|1>" (Vector2.create (Vector2.x z_neg_pos) (Vector2.y z_neg_pos +. 5.0)) 24.0 1.0 Color.black;
    
    end_drawing ();
    loop new_angle_x new_angle_y font

let plot_bloch q () =
  current_qubit := Some q;

  Raylib.set_config_flags [Raylib.ConfigFlags.Msaa_4x_hint; Raylib.ConfigFlags.Window_resizable];
  Raylib.init_window 600 600 "qcaml";
  Raylib.set_window_min_size 400 400;
  Raylib.set_target_fps 60;
  let font_path = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf" in
  let font, should_unload = 
    if Sys.file_exists font_path then
      (Raylib.load_font font_path, true)
    else
      (Raylib.get_font_default (), false)
  in
  loop 0.5 0.8 font;
  if should_unload then Raylib.unload_font font