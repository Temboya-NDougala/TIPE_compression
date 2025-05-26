let zip filename =
  let arbre_encodage = Arbres.arbre_encodage (open_in filename) in
  let tab = Code_table.of_tree arbre_encodage in
  let in_c = open_in filename in
  let out_c = open_out (filename^".hff") in
  Arbres.ecrire_arbre out_c arbre_encodage;
  let out_s = Bit_wise_channel.of_out_channel out_c in
  Code_table.encode tab in_c out_s;
  Bit_wise_channel.close_out_stream out_s; (*out_c is closed at that line*)
  close_in in_c
;;
let unzip filename =
  let suffix = String.sub filename ((String.length filename) - 4) 4 in
  if suffix <> ".hff" then raise (Invalid_argument "can only unzip .hff files")
  else
    let preffix = String.sub filename 0 ((String.length filename) - 4) in
    let in_c = open_in filename in
    let arbre_decodage = Arbres.lire_arbre in_c in
    let in_s = Bit_wise_channel.of_in_channel in_c in
    let out_c = open_out preffix in
    Arbres.decoder out_c in_s arbre_decodage;
    Bit_wise_channel.close_in_stream in_s; (*in_c is closed at that line*)
    close_out out_c;
;;