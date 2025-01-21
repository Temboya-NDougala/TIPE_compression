exception Invalid_stream
(**
    Typically occurs when a file that was written
    byte-wise (ie w/ an out_channel instead of an out_stream)
    is oppened as a bit-wise stream.*)

exception End_of_stream
(**
    Raised when reaching the end of a bit-wise stream.*)

type in_stream
(**
    flux de donnees entrant que l'on peut manipuler bit par bit,
    contrairement aux flux implementes dans la librairie standard,
    ou l'on maipule les donnees octet par octet.*)

val of_in_channel : In_channel.t -> in_stream
(**
    [of_in_channel out] retourne un flux de donnees bit-a-bit a
    partir de n'importe quel flux de donnees entrant.*)

val read_bit : in_stream -> int
(**
    [read_bit istream] lit le premier bit de [istream].*)

val read_n_bits : in_stream -> int -> int
(**
    [read_n_bits istream n] lit les [n] premiers bits de [istream]*)

type out_stream
(**
    flux de donnees sortant que l'on peut manipuler bit par bit,
    contrairement aux flux implementes dans la librairie standard,
    ou l'on maipule les donnees octet par octet.*)

val of_out_channel : Out_channel.t -> out_stream
(**
    [of_out_channel out] retourne un flux de donnees bit-a-bit a
    partir de n'importe quel flux de donnees sortant.*)

val write_bit : out_stream -> int -> unit
(**
    [write_bit out to_write] ecrits le bit de poids faible de [to_write] dans
    le flux bit-a-bit [out].*)

val write_n_bits : out_stream -> int -> int -> unit
(**
    [write_n_bits out n to_write] ecrits les [n] bits de poids faible de
    [to_write] en ordre de poids croissant.
    eg : [write_n_bits out 4 13] ecrits "1011" dans [out] et pas "1101"*)

val close_out_stream : out_stream -> unit
(**
    [close_out_stream out] must called to close a binary stream.
    Closing the underlying byte-wise channel instead can lead to a garbage file.*)