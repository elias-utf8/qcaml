open Quantum

let () =
  let q = Qubit.zero () in
  Gate.h q;
  Gate.z q;
  Gate.h q;
  Printf.printf (Qubit.print () q);
  Visualization.plot_bloch q;
