type 'a stream =
  {
    channel : 'a; (*byte channel, of type in_channel or out_channel*)
    mutable buffer : int;
    (*initialized w/ 24 bits when reading*)
    mutable buffer_size : int; (*number of bits in the buffer*)
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
(**
  Bit-wise streams for reading.
  Insertion in the buffer is right-to-left.*)

let incr_buffer_read s =
  (*precondition : s.buffer_size = 16
  postcondition :
  si le bit suivant de s.channel existe,
  alors s.buffer_size = 24, et les 8 bits de poids le plus faible du buffer
  sont l'octet suivant du canal
  sinon, (on a atteint un end of file)
  s.buffer_size est le nombre de bits signifiant de l'avant dernier octet du flux
  et le s.buffer est l'avant dernier octect de ce flux*)
  try
    s.buffer <- (s.buffer lsl 8) lor (input_byte s.channel);
    s.buffer_size <- 24;
  with
    |End_of_file ->
      s.buffer_size <- s.buffer mod 256;
      s.buffer <- s.buffer lsr 8

let of_in_channel ichannel =
  try
    let res = {channel = ichannel;
      buffer = 0;
      buffer_size = 16;
      }
    in
    res.buffer <- input_byte ichannel; (*reading first byte*)
    res.buffer <- (res.buffer lsl 8) lor (input_byte ichannel); (*reading second byte*)
    incr_buffer_read res;
    res
  with
  | End_of_file -> raise Invalid_stream

let read_bit s =
  if s.buffer_size = 0 then raise End_of_stream;
  let res = (s.buffer lsr (s.buffer_size - 1)) mod 2 in
  s.buffer_size <- s.buffer_size - 1;
  if s.buffer_size = 16 then incr_buffer_read s;
  res

let read_n_bits istream n =
  let rec aux n =
    if n <= 0 then ""
    else (*n > 0*)
      let first = Int.to_string (read_bit istream) in
      first ^ (aux (n - 1))
  in
  aux n

let close_in_stream istream =
  close_in istream.channel

type out_stream = Out_channel.t stream
(**
  Bit-wise streams for writting.
  Insertion in the buffer is right-to-left.*)

let of_out_channel (ochannel : out_channel) =
  {channel = ochannel;
  buffer = 0;
  buffer_size = 0;}


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
      ostream.buffer <- 0;
      ostream.buffer_size <- 0
    end

let write_n_bits n out to_write =
  let rec aux n =
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