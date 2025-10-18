type complex = {
  re : float;
  im : float;
}

let zero = { re = 0.0; im = 0.0 }

let one = { re = 1.0; im = 0.0 }

let minus_one = { re = -1.0; im = 0.0 }

let cadd c1 c2 =
  { re = c1.re +. c2.re;
    im = c1.im +. c2.im }

let cmul c1 c2 =
  { re = c1.re *. c2.re -. c1.im *. c2.im;
    im = c1.re *. c2.im +. c1.im *. c2.re }

let csub c1 c2 =
  { re = c1.re -. c2.re;
    im = c1.im -. c2.im }

let cconj c =
  { re = c.re;
    im = -. c.im }

let cmul_scalar r c =
  { re = r *. c.re;
    im = r *. c.im }
