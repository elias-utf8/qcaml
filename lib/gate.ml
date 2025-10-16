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
