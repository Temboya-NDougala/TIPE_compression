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
        (Arbres.fusion
          (Arbres.feuille '!' 0)
          (Arbres.feuille '\n' 0)
        )
      )
    )
;;

let test () =
  let encode_in_c = open_in "source.txt" in
  let encode_out_s = Bit_wise_channel.of_out_channel (open_out "dest.txt") in
  let tab = Code_table.of_tree a2 in
  Code_table.encode tab encode_in_c encode_out_s;
  Bit_wise_channel.close_out_stream encode_out_s;
  close_in encode_in_c;
  let decode_in_s = Bit_wise_channel.of_in_channel (open_in "dest.txt") in
  let decode_out_c = open_out "back_source.txt" in
  Arbres.decoder decode_out_c decode_in_s a2;
  Bit_wise_channel.close_in_stream decode_in_s;
  close_out decode_out_c
;;

test()
