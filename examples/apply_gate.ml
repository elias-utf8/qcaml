open Quantum

let () =
  let q = Qubit.zero () in
  Gate.h q;
  Gate.t q;
  Visualization.plot_bloch q