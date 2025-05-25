type 'a t = {
  mutable taille : int;
  tab : ('a * int) array}

let creer default =
  { taille = 0;
  tab = Array.make 2048 (default, 0)
  }
let est_vide t =
  t.taille = 0

let enfant_gauche i = 2*i + 1

let enfant_droit i = 2*i + 2

let parent i = (i - 1) / 2

let exchange t i j =
  let tmp = t.tab.(i) in
  t.tab.(i) <- t.tab.(j);
  t.tab.(j) <- tmp

let priorite t i =
  let _, prio = t.tab.(i) in
  prio

let inserer t x p =
  let prio = priorite t in
  let swap = exchange t in
  let rec remonter i =
    if i > 0 then
      begin
        let parent_i = parent i in
        if prio parent_i > prio i then
          swap parent_i i;
          remonter parent_i
      end
  in
  t.tab.(t.taille) <- (x, p);
  remonter t.taille

let retirer t =
  let prio = priorite t in
  let swap = exchange t in
  let enfant_min  i =
    let eg = enfant_gauche i in
    let ed = enfant_droit i in
    if ed < t.taille - 1 then
      (*si l'enfant droit est dans l'arbre privé du dernier element,
      alors enfants droit et gauche sont definis.*)
      if prio ed < prio eg then Some ed else Some eg
    else if eg < t.taille - 1 then Some eg
    else Option.none
  in
  let rec descendre i =
    match enfant_min i with
    | None -> ()
    | Some e ->
      if prio i > prio e then swap e i; descendre e
  in
  swap 0 (t.taille - 1);
  descendre 0;
  t.taille <- t.taille - 1;
  t.tab.(t.taille)