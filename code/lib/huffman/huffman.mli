val zip : string -> unit
(**
    [zip filename] creates a compressed version of the file [filename]
    using Huffman's algorithm.*)

val unzip : string -> unit
(**
    [unzip filename] creates an unzipped version of [filename].
    Raises an exception if the file wasn't zipped using [zip filename].
    [filename] must have [".hff"] as a suffix, raises an exception if not.*)