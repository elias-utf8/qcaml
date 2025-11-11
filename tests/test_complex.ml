open Quantum.Complex

let test_cadd () =
  let c1 = { re = 1.0; im = 2.0 } in
  let c2 = { re = 3.0; im = 4.0 } in
  let r = cadd c1 c2 in
  Alcotest.(check (float 0.0001)) "re" 4.0 r.re;
  Alcotest.(check (float 0.0001)) "im" 6.0 r.im

let test_cmul() =
  let c1 = { re = 3.0; im = 2.0 } in
  let c2 = { re = 7.0; im = 2.0 } in
  let r = cmul c1 c2 in
  Alcotest.(check (float 0.0001)) "re" 17.0 r.re;
  Alcotest.(check (float 0.0001)) "im" 20.0 r.im

let test_csub() =
  let c1 = { re = 5.0; im = 3.0 } in
  let c2 = { re = 4.0; im = 1.0 } in
  let r = csub c1 c2 in
  Alcotest.(check (float 0.0001)) "re" 1.0 r.re;
  Alcotest.(check (float 0.0001)) "im" 2.0 r.im

let test_cconj() =
  let c = { re = 1.0; im = 9.0 } in
  let r = cconj c in
  Alcotest.(check (float 0.0001)) "re" 1.0 r.re;
  Alcotest.(check (float 0.0001)) "im" (-9.0) r.im

let test_cmul_scalar() = 
  let c = { re = 4.0; im = 2.0 } in
  let s = 4.0 in
  let r = cmul_scalar s c in
  Alcotest.(check (float 0.0001)) "re" 16.0 r.re;
  Alcotest.(check (float 0.0001)) "im" 8.0 r.im

let test_cmod_squared() =
  let c = { re = 3.0; im = 4.0 } in
  let r = cmod_squared c in
  Alcotest.(check (float 0.0001)) "cmod_squared" 25.0 r
 
let () =
  let open Alcotest in
  run "Complex tests" [
    "addition", [ test_case "cadd" `Quick test_cadd ];
    "multiplication", [ test_case "cmul" `Quick test_cmul];
    "soustraction", [test_case "csub" `Quick test_csub];
    "conjugate", [test_case "cconj" `Quick test_cconj];
    "scalar multiplication", [test_case "cmul_scalar" `Quick test_cmul_scalar];
    "modulus squared", [test_case "cmod_squared" `Quick test_cmod_squared]
  ]
