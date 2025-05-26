type t = Feuille of char * int | Noeud of int * t * t

let occ a =
  (*nombre d'occurence des caracteres de a*)
  match a with
  | Feuille(_, occ) | Noeud(occ, _, _) -> occ

let feuille c occ = Feuille(c, occ)

let fusion ag ad =
  let occ_total = (occ ag) + (occ ad) in
  Noeud(occ_total, ag, ad)

let rec print_tree a = match a with
| Feuille(c, occ) ->
  print_string "{'";
  print_char c;
  print_string "', ";
  print_int occ;
  print_string "}"
| Noeud(occ, ag, ad) ->
  print_string "(";
  print_int occ;
  print_string ", ";
  print_tree ag;
  print_string ", ";
  print_tree ad;
  print_string ")"

let arbre_encodage channel =
  let tab_occurences channel =
    let res = Array.make 256 0 in
    let rec count_occ channel = match In_channel.input_byte channel with
    | None -> ()
    | Some c ->
      res.(c) <- res.(c) + 1;
      count_occ channel
    in
    count_occ channel;
    In_channel.close channel;
    res
  in
  let inserer_dans_tas tab_occ =
    let res = Tas_binaire.creer (Feuille('0', 0)) in
    let put = Tas_binaire.inserer res in
    for i = 0 to 255 do
      put (feuille (Char.chr i) tab_occ.(i)) tab_occ.(i)
    done;
    res
  in
  let rec arbre_final tas =
    let a1 = Tas_binaire.retirer tas in
    if Tas_binaire.est_vide tas then a1
    else
      let a2 = Tas_binaire.retirer tas in
      let a = fusion a1 a2 in
      Tas_binaire.inserer tas a (occ a);
      arbre_final tas
  in
  arbre_final (inserer_dans_tas (tab_occurences channel))

let ecrire_arbre channel a =
  let rec aux a = match a with
  | Feuille(c, _) ->
    output_char channel '"';
    output_char channel c;
  | Noeud(_, ag, ad) ->
    output_char channel '+';
    aux ag;
    aux ad
  in
  aux a

let rec lire_arbre channel = match In_channel.input_char channel with
| Some('"') -> feuille (input_char channel) 0
| Some('+') ->
  let ag = lire_arbre channel in
  let ad = lire_arbre channel in
  fusion ag ad
|_ -> raise (Invalid_argument("echec de lecture de l'arbre"))

let decoder out_c in_s a =
  let write_char = Out_channel.output_char out_c in
  let rec decoder_prefixe a = match a with
  | Feuille(c, _) -> write_char c
  | Noeud(_, ag, ad) ->
    match Bit_wise_channel.read_bit in_s with
    | 0 -> decoder_prefixe ag
    | 1 -> decoder_prefixe ad
    | _ -> raise (Invalid_argument "decoding failed : error in bit reading")
  in
  let rec aux () =
    try
      decoder_prefixe a;
      aux ()
    with
    | Bit_wise_channel.End_of_stream -> ()
  in
  aux ()