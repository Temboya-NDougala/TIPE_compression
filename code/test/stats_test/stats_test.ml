type compressor = {
  extension : string;
  (*"." included in extension*)
  zip : string -> string -> unit;
  (**
    [zip src dest] writes a compressed version of the file [src]
    in file [dest].*)
  unzip : string -> string -> unit
  (**
    [unzip src dest] writes an unzipped version of [src] in file [dest].
    Raises an exception if the file wasn't zipped using [zip src dest].
    [src] must have [extension] as a suffix, raises an exception if not.*)}

type file = {
  filetype : string;
  filename : string;
  extension : string
  (*"." included in extension*)
}

type info = float * float * bool
(*tuple (temps de compression, temps de decompression, taux de compression, restitution reussie)*)

let compressors_list = [
  {
    extension = ".hff";
    zip = Huffman.zip;
    unzip = Huffman.unzip
  }
]

let test_files = [
  ("english", ".txt",
    ["bee_movie"; "bible"]
  );
  ("giberish", ".txt",
    ["test1"]
  );
  ("pdf", ".pdf",
    ["compression_AI_era"; "elements_of_information_theory"]
  )
]

let build_file filetype extension filename =
    {
      filetype = filetype;
      filename = filename;
      extension = extension
    }

let test_on_one_file (compressor : compressor) file : info =
  let folder = "test_files/"^file.filetype^"/"^file.filename^"/" in
  let total_filename = file.filename^file.extension in
  let src = folder^total_filename in
  let dest = folder^"compressed/"^total_filename^compressor.extension in
  let zip_deb  = Sys.time() in
  compressor.zip src dest;
  let zip_time = Sys.time() -. zip_deb in
  let unzip_deb = Sys.time() in
  compressor.unzip dest src;
  let unzip_time = Sys.time() -. unzip_deb in
  let archive_channel = open_in (folder^file.filename^"_archive"^file.extension) in
  let unzipped_channel = open_in src in
  let success = In_channel.input_all archive_channel = In_channel.input_all unzipped_channel in
  close_in archive_channel;
  close_in unzipped_channel;
  (zip_time, unzip_time, success)
;;

let test_on_filetype (compressor : compressor) (filetype, extension, file_list) : info =
  let combine (zip_time1, unzip_time1, success1) (zip_time2, unzip_time2, success2) =
    (zip_time1 +. zip_time2, unzip_time1 +. unzip_time2, success1 && success2)
  in
  let build_file = build_file filetype extension in
  let test_on_one_file = test_on_one_file compressor in
  let total = List.fold_left (fun info_acc filename -> combine info_acc (test_on_one_file (build_file filename)))
    (0., 0., true) file_list
  in
  let (total_zip_time, total_unzip_time, total_success) = total in
  let number_of_files = float (List.length file_list) in
  (total_zip_time /. number_of_files, total_unzip_time /. number_of_files, total_success)
;;

let test compressor =
  let test_on_filetype = test_on_filetype compressor in
  let print_test_result (filetype_name, extension, _) ((avg_zip_time, avg_unzip_time, total_success) : info) =
    Printf.printf "file type : %s\nextension : %s\n=================================\n" filetype_name extension;
    Printf.printf "average zip time : %fs\naverage unzip time : %fs\ntotal success : %s\n----------------------------------------\n"
    avg_zip_time avg_unzip_time (Bool.to_string total_success)
  in
  List.iter (fun filetype -> print_test_result filetype (test_on_filetype filetype)) test_files
;;

List.iter test compressors_list;;