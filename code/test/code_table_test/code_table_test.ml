let of_tree_test () =
  let a1 =
    Arbres.fusion
      (Arbres.fusion
        (Arbres.feuille 'a' 0)
        (Arbres.feuille 'b' 0)
      )
      (Arbres.feuille 'c' 0)
  in
  Code_table.print (Code_table.of_tree a1);
  print_string "---------------------------------------\n";
  let a2 = 
    Arbres.fusion
      (Arbres.fusion
        (Arbres.feuille 'a' 0)
        (Arbres.feuille 'b' 0)
      )
      (Arbres.fusion
        (Arbres.feuille 'c' 0)
        (Arbres.fusion
          (Arbres.feuille ' ' 0)
          (Arbres.feuille '!' 0)
        )
      )
  in
  Code_table.print (Code_table.of_tree a2);
  print_string "\n"
;;

of_tree_test()