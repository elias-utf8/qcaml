open Qubit

let x q =
  let new_alpha = Complex.cadd
    (Complex.cmul Complex.zero q.alpha)
    (Complex.cmul Complex.one q.beta) in
  let new_beta = Complex.cadd
    (Complex.cmul Complex.one q.alpha)
    (Complex.cmul Complex.zero q.beta) in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let y q =
  let i = { Complex.re = 0.0; im = 1.0 } in
  let minus_i = { Complex.re = 0.0; im = -1.0 } in
  let new_alpha = Complex.cmul i q.beta in
  let new_beta = Complex.cmul minus_i q.alpha in
  q.alpha <- new_alpha;
  q.beta <- new_beta

let z q =
  let new_alpha = Complex.cadd
    (Complex.cmul Complex.one q.alpha)
    (Complex.cmul Complex.zero q.beta) in
  let new_beta = Complex.cadd
    (Complex.cmul Complex.zero q.alpha)
    (Complex.cmul Complex.minus_one q.beta) in
  q.alpha <- new_alpha;
  q.beta <- new_beta
