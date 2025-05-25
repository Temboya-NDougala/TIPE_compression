type t
(**
    arbres de characteres. Les feuilles sont etiquetees par des caracteres, et chaque noeud N
    est etiquete par le nombre total d'occurences de tous les caracteres aux feuilles du sous-arbre
    enracine en N.*)

(* type codeTable = (char, (int * int)) Hashtbl.t *)
(**
    pour une [codeTable] notee [ct], [find ct c] renvoie un couple [(code, length)], ou [code] est le code compresse
    de [c], ecrite sur un [int], et [length] la longueur de ce code*)

val feuille : char -> int -> t
(**
    [feuille c occ] renvoie une feuille etiquetee par le caractere [c] et l'entier [occ], qui est
    cense etre le nombre d'occurences de [c] dans le text a compresser.*)

val fusion : t -> t -> t
(**
    [fusionne ag ad] renvoie une noeud de la forme [(occ(ag) + occ(ad), ag, ad)]*)

val arbre_encodage : In_channel.t -> t
(**
    [arbre_encodage channel] renvoie l'arbre d'encodage correspondant au canal de lecture [channel].
    Le canal est ferme apres execution de la fonction*)

val ecrire_arbre : Out_channel.t -> t -> unit
(**
    [ecrire_arbre channel a] ecrit l'arbre [a] dans [channel].
    Le canal n'est PAS ferme apres excution de la fonction*)

val lire_arbre : In_channel.t -> t
(**
    [lire_arbre channel] lit l'arbre en prefixe de [channel].
    Ne ferme PAS le canal*)