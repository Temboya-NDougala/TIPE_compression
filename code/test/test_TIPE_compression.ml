open TIPE_compression

let () =
  let output_test = open_out "output_test.txt" in
  let out = Bit_wise_channel.of_out_channel output_test in
  Bit_wise_channel.write_n_bits 16 out (((Char.code 'a') lsl 8) + (Char.code 'b'));
  Bit_wise_channel.write_n_bits 2 out 3;
  Bit_wise_channel.close_out_stream out;
  let output_reading = open_in "output_test.txt" in
  assert (input_byte output_reading = Char.code 'a');
  assert (input_byte output_reading = Char.code 'b');
  assert (input_byte output_reading = 3);
  assert (input_byte output_reading = 2)
