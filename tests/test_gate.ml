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

let test_y () =
  let q = { alpha = one; beta = zero } in
  y q;
  Alcotest.(check (float 0.0001)) "alpha.re" 0.0 q.alpha.re;
  Alcotest.(check (float 0.0001)) "alpha.im" 0.0 q.alpha.im;
  Alcotest.(check (float 0.0001)) "beta.re" 0.0 q.beta.re;
  Alcotest.(check (float 0.0001)) "beta.im" (-1.0) q.beta.im

let test_z () =
  let q = { alpha = one; beta = zero } in
  z q;
  Alcotest.(check (float 0.0001)) "alpha.re" 1.0 q.alpha.re;
  Alcotest.(check (float 0.0001)) "alpha.im" 0.0 q.alpha.im;
  Alcotest.(check (float 0.0001)) "beta.re" 0.0 q.beta.re;
  Alcotest.(check (float 0.0001)) "beta.im" 0.0 q.beta.im

let () =
  let open Alcotest in
  run "Gates tests" [
    "x", [ test_case "x" `Quick test_x ];
    "y", [ test_case "y" `Quick test_y ];
    "z", [ test_case "z" `Quick test_z ]
  ]
