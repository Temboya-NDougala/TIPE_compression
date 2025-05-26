type t
(**
    table qui a un caractere [c] associe un couple [(code, length)], ou
    [code] est le code de Huffman de [c] ecrit sur un eniter et [length]
    la longueur de [code].*)

val print : t -> unit

val of_tree : Arbres.t -> t
(**
    [of_tree a] renvoie la table de codage correspondant a l'arbre de
    Huffman*)

val encode : t -> In_channel.t -> Bit_wise_channel.out_stream -> unit
(**
    [encode tab in_c out_s] ecrit dans [out_s] le contenu de [in_c]
    encode par [tab]*)