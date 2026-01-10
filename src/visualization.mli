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


val get_values : q -> sphere_values

val plot_bloch : unit -> unit