open Quantum

let () =
  let q = Qubit.zero () in

  Printf.printf "Initial: %s\n" (Qubit.print () q);

  Gate.h q;
  Printf.printf "After H: %s\n" (Qubit.print () q);

  Gate.z q;
  Printf.printf "After Z: %s\n" (Qubit.print () q);

  Gate.h q;
  Printf.printf "After second H (|1⟩): %s\n" (Qubit.print () q);
  Visualization.plot_bloch q;
