open Quantum

let () =
  let q0 = Qubit.zero in
  let q1 = Qubit.one in

  Printf.printf "Qubit |0⟩: %s\n" (Qubit.print q0);
  Printf.printf "Qubit |1⟩: %s\n" (Qubit.print q1);
