(**
  @author       Elias GAUTHIER
  file :        measurement.mli
  date :        2025-10-10
  license :     Apache-2.0
  description : Implementation of qubit measurement
*)
open Qubit

(** Measure a qubit in the computational basis.
    This collapses the qubit to either |0⟩ or |1⟩ based on the probability
    amplitudes and returns the measurement result.
    @param q The qubit to measure (will be modified in place)
*)
val measure : q -> unit
