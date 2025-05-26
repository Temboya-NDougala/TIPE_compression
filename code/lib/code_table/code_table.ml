type t = (int * int) array

let get tab c =
  tab.(Char.code c)

let set tab c x =
  tab.(Char.code c) <- x

let of_tree a =
  let res = Array.make 256 (0, 0) in
  let rec lire_arbre code length a = match a with
  | Arbres.Feuille(c, _) -> set res c (code, length)
  | Arbres.Noeud(_, ag, ad) ->
    lire_arbre (code lsl 1) (length + 1) ag;
    lire_arbre ((code lsl 1) + 1) (length + 1) ad
  in
  lire_arbre 0 0 a;
  res

let encode _ _ _ = ()