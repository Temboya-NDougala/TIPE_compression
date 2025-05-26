let a1 =
  Arbres.fusion
    (Arbres.fusion
      (Arbres.feuille 'a' 0)
      (Arbres.feuille 'b' 0)
    )
    (Arbres.feuille 'c' 0)
;;
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
;;
let of_tree_test () =
  Code_table.print (Code_table.of_tree a1);
  print_string "---------------------------------------\n";
  Code_table.print (Code_table.of_tree a2);
  print_string "\n"
;;

let encode_test () =
  let tab = Code_table.of_tree a2 in
  let in_c = open_in "code_table_test_input.txt" in
  let out_s = Bit_wise_channel.of_out_channel (open_out "code_table_test_output.txt") in
  Code_table.encode tab in_c out_s;
  Bit_wise_channel.close_out_stream out_s;
  let output = Bit_wise_channel.of_in_channel (open_in "code_table_test_output.txt") in
  for _ = 0 to 1000 do
    try
      print_int (Bit_wise_channel.read_bit output);
    with
    | Bit_wise_channel.End_of_stream -> ()
  done;
;;

of_tree_test();
print_string "-----------------------------------------------------------\n";
encode_test();
print_char '\n'