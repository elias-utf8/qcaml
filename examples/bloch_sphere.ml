open Quantum

let () =
  let q = Qubit.plus () in
  Measurement.measure q;
  Printf.printf "%s\n" (Qubit.print () q);
