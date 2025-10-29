open Quantum.Qubit
open Quantum.Gate
open Quantum.Measurement
open Quantum.Visualization

let () =
  let q = zero () in
  x q;
  measure q;
  Printf.printf "%s" (print () q);
  flush stdout;
  plot_bloch q;
