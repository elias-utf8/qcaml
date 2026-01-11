open Quantum

let () =
  let q0 = Qubit.zero () in
  Visualization.plot_bloch q0 ();