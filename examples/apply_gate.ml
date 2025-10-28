open Quantum

let () =
  let q = Qubit.zero () in
  Gate.x q;        (* |0⟩ → |1⟩ *)
  Gate.x q;        (* |1⟩ → |0⟩ *)
  Measurement.measure q;
  Printf.printf "%s\n" (Qubit.print q);
  (* Result : |ψ⟩ = (1.00 + 0.00i)|0⟩ + (0.00 + 0.00i)|1⟩ *)
