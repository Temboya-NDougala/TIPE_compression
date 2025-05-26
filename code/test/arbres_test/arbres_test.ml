let print_tree_test () =
  Arbres.print_tree (
    Arbres.fusion
      (Arbres.feuille 'a' 2)
      (Arbres.fusion 
        (Arbres.feuille 'c' 2)
        (Arbres.feuille 'b' 1)
      )
  );
  print_char '\n'
;;

let arbre_encodage_test () =
  let channel = open_in "arbre_encodage_test.txt" in
  Arbres.print_tree (Arbres.arbre_encodage channel)
;;

let ecriture_lecture_test () =
  let filename = "ecriture_lecture_test.txt" in
  let a = Arbres.fusion
    (Arbres.fusion
      (Arbres.feuille '0' 0)
      (Arbres.feuille 'a' 0)
    )
    (Arbres.fusion
      (Arbres.feuille 'b' 0)
      (Arbres.fusion
        (Arbres.feuille 'u' 0)
        (Arbres.feuille 'p' 0)
      )
    )
  in
  let channel1 = open_out filename in
  Arbres.ecrire_arbre channel1 a;
  close_out channel1;
  let channel2 = open_in filename in
  assert (Arbres.lire_arbre channel2 = a);
  (* Arbres.print_tree a; print_char '\n';
  Arbres.print_tree (Arbres.lire_arbre channel2); *)
  close_in channel2
;;

print_tree_test ();
print_string "------------------------------------------------------\n";
arbre_encodage_test ();
print_string "\n------------------------------------------------------\n";
ecriture_lecture_test();
print_char '\n'