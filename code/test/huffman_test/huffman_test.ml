let test_huffman preffix =
  Huffman.zip (preffix^".txt");
  print_string (preffix^".txt zipped\n");
  Huffman.unzip (preffix^".txt.hff");
  let archive_channel = open_in (preffix^"_archive.txt") in
  let unzipped_channel = open_in (preffix^".txt") in
  assert (In_channel.input_all archive_channel = In_channel.input_all unzipped_channel);
  close_in archive_channel;
  close_in unzipped_channel
;;

test_huffman "source";;
test_huffman "bee_movie";;
test_huffman "bible";;