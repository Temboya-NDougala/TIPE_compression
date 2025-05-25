type t = Feuille of char * int | Noeud of int * t * t

let occ a =
  (*nombre d'occurence des caracteres de a*)
  match a with
  | Feuille(_, occ) | Noeud(occ, _, _) -> occ

let feuille c occ = Feuille(c, occ)

let fusion a1 a2 =
  let occ_total = (occ a1) + (occ a2) in
  Noeud(occ_total, a1, a2)

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