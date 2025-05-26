type t = (int * int) array

let get tab c =
  tab.(Char.code c)

let set tab c x =
  tab.(Char.code c) <- x

let print tab =
  print_string "[|";
  for i = 0 to (Array.length tab) - 1 do
    let code, length = tab.(i) in
    Printf.printf "; {'%c' : (0x%x, %d)}" (Char.chr i) code length
  done;
  print_string "|]"

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

let encode tab in_c out_s =
  let rec aux () = match In_channel.input_char in_c with
  | None -> ()
  | Some c ->
    let code, length = get tab c in
    Bit_wise_channel.write_n_bits length out_s code;
    aux ()
  in
  aux ()