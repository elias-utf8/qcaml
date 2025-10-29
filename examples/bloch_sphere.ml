open Quantum.Qubit
open Quantum.Gate
open Quantum.Measurement

let () =
  Printf.printf "=== Test mesures ===\n\n";
  
  (* Test 1: Mesure de |0⟩ → toujours 0 *)
  Printf.printf "Test 1: Mesure de |0⟩ (100 fois)\n";
  let counts_0 = ref 0 and counts_1 = ref 0 in
  for _ = 1 to 100 do
    let q = zero () in
    if measure q = Zero then incr counts_0 else incr counts_1
  done;
  Printf.printf "Résultats: |0⟩=%d, |1⟩=%d (attendu: 100, 0)\n\n" !counts_0 !counts_1;
  
  (* Test 2: Mesure de |+⟩ → 50/50 *)
  Printf.printf "Test 2: Mesure de |+⟩ (1000 fois)\n";
  let counts_0 = ref 0 and counts_1 = ref 0 in
  for _ = 1 to 1000 do
    let q = zero () in
    h q;
    if measure q = Zero then incr counts_0 else incr counts_1
  done;
  Printf.printf "Résultats: |0⟩=%d, |1⟩=%d (attendu: ~500, ~500)\n\n" !counts_0 !counts_1;
  
  (* Test 3: Après mesure, état collapsé *)
  Printf.printf "Test 3: Collapse après mesure\n";
  let q = zero () in
  h q;
  Printf.printf "Avant mesure: %s\n" (print () q);
  let result = measure q in
  Printf.printf "Résultat: %s\n" (match result with Zero -> "|0⟩" | One -> "|1⟩");
  Printf.printf "Après mesure: %s (doit être |0⟩ ou |1⟩)\n" (print () q)
