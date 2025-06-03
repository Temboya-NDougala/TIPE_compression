val zip : string -> string -> unit
(**
    [zip src dest] writes a compressed version of the file [src]
    in file [dest] using Huffman's algorithm.*)

val unzip : string -> string -> unit
(**
    [unzip src dest] writes an unzipped version of [src] in file [dest].
    Raises an exception if the file wasn't zipped using [zip src dest].
    [src] must have [".hff"] as a suffix, raises an exception if not.*)