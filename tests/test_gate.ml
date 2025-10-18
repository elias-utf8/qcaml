open Quantum.Gate
open Quantum.Qubit
open Quantum.Complex

let test_x () =
  let q = { alpha = one; beta = zero } in
  x q;
  Alcotest.(check (float 0.0001)) "alpha.re" 0.0 q.alpha.re;
  Alcotest.(check (float 0.0001)) "alpha.im" 0.0 q.alpha.im;
  Alcotest.(check (float 0.0001)) "beta.re" 1.0 q.beta.re;
  Alcotest.(check (float 0.0001)) "beta.im" 0.0 q.beta.im

let () =
  let open Alcotest in
  run "Gates tests" [
    "x", [ test_case "x" `Quick test_x ]
  ]
