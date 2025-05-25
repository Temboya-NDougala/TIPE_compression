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

print_tree_test ()