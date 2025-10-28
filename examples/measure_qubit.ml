open Quantum

let () =
  Random.self_init ();

  Printf.printf "1000 measurements : \n";
  let count_zero = ref 0 in
  for _ = 1 to 1000 do
    let q = Qubit.plus () in
    Measurement.measure q;
    if Complex.cmod q.alpha > 0.5 then incr count_zero
  done;
  Printf.printf "Probability of |0⟩: %.2f%% (expected: ~50%%)\n"
    (float_of_int !count_zero /. 10.0)
