open Complex

type q = { alpha : complex; beta : complex }

(** Qubit |0⟩ *)
let zero = { alpha = Complex.one; beta = Complex.zero }

(** Qubit |1⟩ *)
let one = { alpha = Complex.zero; beta = Complex.one }

let print q =
  Printf.sprintf "|ψ⟩ = (%.2f + %.2fi)|0⟩ + (%.2f + %.2fi)|1⟩"
    q.alpha.re q.alpha.im
    q.beta.re q.beta.im
