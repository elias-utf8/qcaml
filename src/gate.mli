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

(** Y gate
    Matrice Y = [[0, -i], [i, 0]]
    Result: [α'] = [0·α + i·β] = [i·β]
            [β']   [(-i)·α + 0·β] = [-i·α]
*)
val y : q -> unit

(** Z gate
    Matrice Z = [[1, 0], [0, -1]]
    Result: [α'] = [1·α + 0·β] = [α]
            [β']   [0·α + (-1)·β] = [-β]
*)
val z : q -> unit

(** Hadamard gate
    Matrice H = 1/√2 × [[1, 1], [1, -1]]
    Result: [α'] = 1/√2 × [1·α + 1·β] = (α + β)/√2
            [β'] = 1/√2 × [1·α + (-1)·β] = (α - β)/√2
*)
val h : q -> unit
