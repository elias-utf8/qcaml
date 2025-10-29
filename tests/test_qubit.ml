open Quantum.Qubit

(** Test that qubit |0⟩ has correct amplitudes *)
let test_zero () =
  let q = zero () in
  let alpha = get_alpha q in
  let beta = get_beta q in
  Alcotest.(check (float 0.0001)) "alpha.re" 1.0 alpha.re;
  Alcotest.(check (float 0.0001)) "alpha.im" 0.0 alpha.im;
  Alcotest.(check (float 0.0001)) "beta.re" 0.0 beta.re;
  Alcotest.(check (float 0.0001)) "beta.im" 0.0 beta.im

(** Test that qubit |1⟩ has correct amplitudes *)
let test_one () =
  let q = one () in
  let alpha = get_alpha q in
  let beta = get_beta q in
  Alcotest.(check (float 0.0001)) "alpha.re" 0.0 alpha.re;
  Alcotest.(check (float 0.0001)) "alpha.im" 0.0 alpha.im;
  Alcotest.(check (float 0.0001)) "beta.re" 1.0 beta.re;
  Alcotest.(check (float 0.0001)) "beta.im" 0.0 beta.im

(** Test print function for |0⟩ *)
let test_zero_print () =
  let q = zero () in
  let s = print () q in
  Alcotest.(check string) "print |0⟩" "|ψ⟩ = (1.00 + 0.00i)|0⟩ + (0.00 + 0.00i)|1⟩" s

(** Test print function for |1⟩ *)
let test_one_print () =
  let q = one () in
  let s = print () q in
  Alcotest.(check string) "print |1⟩" "|ψ⟩ = (0.00 + 0.00i)|0⟩ + (1.00 + 0.00i)|1⟩" s

let () =
  let open Alcotest in
  run "Qubit tests" [
    "zero state", [
      test_case "zero amplitudes" `Quick test_zero;
      test_case "zero print" `Quick test_zero_print;
    ];
    "one state", [
      test_case "one amplitudes" `Quick test_one;
      test_case "one print" `Quick test_one_print;
    ];
  ]
