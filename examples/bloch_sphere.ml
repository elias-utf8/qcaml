open Quantum

let () =
  let q = Qubit.plus () in
  Visualization.plot_bloch q;
  Measurement.measure q;
  Printf.printf "%s\n" (Qubit.print () q);
