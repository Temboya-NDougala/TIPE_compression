(* open TIPE_compression *)

let bitwise_writing_test() =
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
;;

let bitwise_reading_test() =
  let reading_test1 = Bit_wise_channel.of_out_channel (open_out "reading_test1.txt") in
  Bit_wise_channel.write_n_bits 8 reading_test1 (Char.code '~');
  Bit_wise_channel.write_n_bits 4 reading_test1 2;
  Bit_wise_channel.close_out_stream reading_test1;
  let reading1 = Bit_wise_channel.of_in_channel (open_in "reading_test1.txt") in
  (* for _ = 1 to 12 do
    print_int (Bit_wise_channel.read_bit reading1);
  done; *)
  assert (Bit_wise_channel.read_n_bits reading1 12 = "011111100010");
  (* print_char '\n'; *)
  Bit_wise_channel.close_in_stream reading1;
  let reading_test2 = Bit_wise_channel.of_out_channel (open_out "reading_test2.txt") in
  Bit_wise_channel.write_n_bits 9 reading_test2 256;
  Bit_wise_channel.close_out_stream reading_test2;
  let reading2 = Bit_wise_channel.of_in_channel (open_in "reading_test2.txt") in
  (* for _ = 1 to 9 do
    print_int (Bit_wise_channel.read_bit reading2);
  done; *)
  (* print_string (Bit_wise_channel.read_n_bits reading2 9); *)
  assert (Bit_wise_channel.read_n_bits reading2 9 = "100000000");
;;

bitwise_writing_test();
bitwise_reading_test();