Require Import Frap.Frap.

Inductive expr :=
| Const (n : nat)
| Var (x : var)
| Plus (e1 e2 : expr)
| Times (e1 e2 : expr).

Example ex1 := Var "y".

Definition valuation := fmap var nat.

Fixpoint interp (e : expr) (v : valuation) : nat :=
  match e with
  | Const n => n
  | Var x =>
    match v $? x with
    | None => 0
    | Some n => n
    end
  | Plus e1 e2 => interp e1 v + interp e2 v
  | Times e1 e2 => interp e1 v * interp e2 v
  end.

Example val1: valuation := $0 $+ ("x", 17) $+ ("y", 3).
Example val2: valuation := $0 $+ ("x", 17) $- "x".

Compute interp ex1 val2.