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

print_tree_test ();
print_string "------------------------------------------------------\n";
arbre_encodage_test ();
print_char '\n'