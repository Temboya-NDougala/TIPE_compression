type 'a stream =
  {
    channel : 'a; (*byte channel, of type in_channel or out_channel*)
    mutable buffer : int;
    (*initialized w/ 24 bits when reading*)
    mutable buffer_size : int; (*number of bits in the buffer*)
(*  mutable number_of_signgificant_bits : int *)
    (*number of bits that should be read int the penultimate byte*)
  }

exception Invalid_stream
(**
    Typically occurs when a file that was written
    byte-wise (ie w/ an out_channel instead of an out_stream)
    is oppened as a bit-wise stream.*)

exception End_of_stream
(**
    Raised when reaching the end of a bit-wise stream.*)

type in_stream = In_channel.t stream

let of_in_channel _ =
  failwith "TODO"

let read_bit _ =
  failwith "TODO"

let read_n_bits _ _ =
  failwith "TODO"

let close_in_stream _ =
  failwith "TODO"

type out_stream = Out_channel.t stream
(**
  Bit-wise streams for writting.
  Insertion in the buffer is right-to-left.*)

let of_out_channel (ochannel : out_channel) =
  {channel = ochannel;
  buffer = 0;
  buffer_size = 0;
  (* number_of_signgificant_bits = -1 *) (*useless when writing*)}


let write_bit ostream to_write =
  (*the buffer is considered of size 8.
  If the buffer is full, then write its content down and empty
  the buffer.
  Then, in any case, insert the bit to write in the buffer.*)
  ostream.buffer <- (ostream.buffer lsl 1) lor (to_write mod 2);
  ostream.buffer_size <- ostream.buffer_size + 1;
  if ostream.buffer_size = 8 then
    begin
      output_byte ostream.channel (ostream.buffer mod 256);
      ostream.buffer_size <- 0
    end

let write_n_bits n out to_write =
  let rec aux n=
    if n > 0 then
      begin
        write_bit out (to_write lsr (n - 1));
        aux (n - 1)
      end
  in
  aux n

let close_out_stream ostream =
  output_byte ostream.channel ostream.buffer;
  output_byte ostream.channel ostream.buffer_size;
  close_out ostream.channel