let test_huffman preffix extension =
  let base_name = preffix^"/"^preffix^"."^extension in
  Huffman.zip base_name (base_name^".hff");
  print_string (preffix^"."^extension^" zipped\n");
  Huffman.unzip (base_name^".hff") base_name;
  let archive_channel = open_in (preffix^"/"^preffix^"_archive."^extension) in
  let unzipped_channel = open_in base_name in
  assert (In_channel.input_all archive_channel = In_channel.input_all unzipped_channel);
  close_in archive_channel;
  close_in unzipped_channel
;;

test_huffman "source" "txt";;
test_huffman "bee_movie" "txt";;
test_huffman "bible" "txt";;
test_huffman "compression_AI_era" "pdf";;
test_huffman "elements_of_information_theory" "pdf";;
test_huffman "notre_dame_d_amour" "txt";;