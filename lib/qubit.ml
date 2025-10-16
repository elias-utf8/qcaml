open Complex

type q = { alpha : complex; beta : complex }

(** Qubit |0⟩ *)
let zero = { alpha = Complex.one; beta = Complex.zero }

(** Qubit |1⟩ *)
let one = { alpha = Complex.zero; beta = Complex.one }

(** Superposition |+⟩ *)
let plus = {
  alpha = { re = 1.0 /. sqrt 2.0; im = 0.0 };
  beta  = { re = 1.0 /. sqrt 2.0; im = 0.0 };
}

(** Superposition |-⟩ *)
let minus = {
  alpha = { re = 1.0 /. sqrt 2.0; im = 0.0 };
  beta  = { re = -.1.0 /. sqrt 2.0; im = 0.0 };
}

(** Alpha getter *)
let get_alpha q = q.alpha

(** Beta getter *)
let get_beta q = q.beta

let print q =
  Printf.sprintf "|ψ⟩ = (%.2f + %.2fi)|0⟩ + (%.2f + %.2fi)|1⟩"
    q.alpha.re q.alpha.im
    q.beta.re q.beta.im
