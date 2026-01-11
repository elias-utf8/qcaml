(**
  @author       Elias GAUTHIER
  file :        measurement.mli
  date :        2025-27-10
  license :     Apache-2.0
  description : Visualization of qubit
*)
open Qubit

(** Type holding values for Bloch sphere visualization *)
type sphere_values = {
  phi : float;
  theta : float;
  alpha_re : float;
  alpha_im : float;
  beta_re : float;
  beta_im : float;
}

(** Get the Cartesian coordinates of a qubit on the Bloch sphere *)
val get_cartesian_coordinates : q -> float * float * float

(** Get the values needed for Bloch sphere visualization from a qubit *)
val get_values : q -> sphere_values

(** Plot the Bloch sphere and the qubit state *)
val plot_bloch : q -> unit -> unit