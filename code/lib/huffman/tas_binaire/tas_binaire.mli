type 'a t
(**
    tas bianire min mutable, capacite maximale 2048*)

exception Empty_heap
(**
    Levee quand on execute [retirer t] lorsque [t] est vide.*)

val creer : 'a -> 'a t
(**
    [creer default] cree un tas binaire vide dont le tableau de contenu contient uniquement
    la valeur [default]*)

val est_vide : 'a t -> bool
(**
    [est_vide t] renvoie si [t] est vide.*)

val inserer : 'a t -> 'a -> int -> unit
(**
    [inserer t x p] insere l'element [x] dans le tas [t] avec la priorite [p].*)

val retirer : 'a t -> 'a
(**
    [retirer t] retire l'element de plus petite priorite de [t] pour le renvoyer*)