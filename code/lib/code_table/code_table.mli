type t
(**
    table qui a un caractere [c] associe un couple [(code, length)], ou
    [code] est le code de Huffman de [c] ecrit sur un eniter et [length]
    la longueur de [code].*)

val of_tree : Arbres.t -> t
(**
    [of_tree a] renvoie la table de codage correspondant a l'arbre de
    Huffman*)

val encode : t -> In_channel.t -> Out_channel.t -> unit
(**
    [encode tab in_c out_c] ecrit dans [out_c] le contenu de [in_c]
    encode par [tab]*)