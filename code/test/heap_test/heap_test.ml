let est_vide_test () =
  let tas = Tas_binaire.creer 0 in
  assert (Tas_binaire.est_vide tas);
  Tas_binaire.inserer tas 42 7;
  assert (not (Tas_binaire.est_vide tas));
  let _ = Tas_binaire.retirer tas in
  assert (Tas_binaire.est_vide tas)
;;

let insert_test () =
  let tas = Tas_binaire.creer "0" in
  let tab = Array.of_list (String.split_on_char ' ' "a b c d e f g h i j k") in
  for i = 0 to (Array.length tab) - 1 do
    Tas_binaire.inserer tas tab.(i) i
  done;
  Tas_binaire.inserer tas "l" (-1);
  for _ = 0 to (Array.length tab) do
    print_string (Tas_binaire.retirer tas)
  done;
  print_char '\n';
  try
    let _ = Tas_binaire.retirer tas in ()
  with
  | Tas_binaire.Empty_heap -> print_string "Empty_heap raised\n"
;;

est_vide_test ();
insert_test();