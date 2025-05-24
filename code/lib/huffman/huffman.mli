val zip : string -> unit
(**
    [zip filename] creates a compressed version of the file [filename]
    using Huffman's algorithm.*)

val unzip : string -> unit
(**
    [unzip filename] creates an unzipped version of [filename].
    Raises an excpetion if the file wasn't zipped using [zip filename].*)