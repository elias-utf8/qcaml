(**
  @author       Elias GAUTHIER
  file :        gate.mli
  date :        2025-16-02
  license :     Apache-2.0
  description : Implementation of basic gates (X, Z, Y, Hadamard)
*)
open Qubit

(** X gate
    Matrice X = [[0, 1], [1, 0]]
    Result: [α'] = [0·α + 1·β] = [β]
            [β']   [1·α + 0·β]   [α]
*)
val x : q -> unit
