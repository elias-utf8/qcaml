open Quantum

let () =
  (* Initialize qubit |0⟩ *)
  let q = Qubit.zero () in

  (* Apply H and Z gate (flip like X gate) *)
  Gate.h q;
  Gate.z q;
  Gate.h q;
  
  (* Visualize qubit on Bloch sphere *)
  Visualization.plot_bloch q ();
  
  (* Measure qubit and display its state *)
  Measurement.measure q;
  Printf.printf "%s\n" (Qubit.print () q);