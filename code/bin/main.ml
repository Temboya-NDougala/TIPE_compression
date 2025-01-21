open TIPE_compression

let () =
  let output_test = open_out "output_test.txt" in
  let out = Bit_wise_channel.of_out_channel output_test in
  Bit_wise_channel.write_n_bits 8 out (Char.code 'a');
  Bit_wise_channel.write_n_bits 8 out (Char.code 'b');
  Bit_wise_channel.close_out_stream out;