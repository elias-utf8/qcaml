open Quantum

let () =
  let q0 = Qubit.zero in
  let q1 = Qubit.one in
  Gate.x q0;
  Gate.x q1;

  Printf.printf "Qubit |0⟩ after X gate : %s\n" (Qubit.print q0);
  Printf.printf "Qubit |1⟩ after X gate : %s\n" (Qubit.print q1);
