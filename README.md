# TIPE_compression
2eme TIPE, qui porte sur les algorithmes de compression de donnees.

## Objectif principal : creer une bibliotheque de compression de fichiers

+ implementer Huffman
+ implementer un codage arithmétique
+ reflexion theorique sur les algorithmes de compression (etudier théorie de l'information)


## Algorithmes a disposition

+ ANS
+ codage arithmetique
+ ondelettes (chrominance, luminance, teinte)

## TODO
+ implementer ecriture bit-a-bit sur un fichier
+ Huffman
    + implementer arbres et tas min

## Notes pour la bibliographie commentée
+ Il n'existe pas d'algorithmes de codage parfait, ie sans perte et qui compresse strictement tous les mots [3]
    + Plus exactement, pour tout algorithme lossless, on a 3 certitudes :
        1. Il existe un mot dans la version compression est de longueur supérieure ou égale au mot initial
        2. S'il existe un mot strictement compressé, il en existe au moins un autre dont la version compressée est strictement plus longue que le mot initial
        3. Les itérations du compresseurs sur un mot de départ quelconque aboutissent à l'un des deux cas suivant
+ Cependant, dans la pratique, les fichiers ne sont pas totalement aléatoires, et il existe des algorithmes spécialisés qui utilisent les informations fournies par le contexte de (dé)compression (le type de fichier à décompresser, typiquement). [3]


## Sources
1. [video de vulgarisation sur les ondelettes](https://youtu.be/vpmlGMZSpvQ?si=35RCm1T92-lWqZgx)
2. [article wikipedia sur la compression de donnees](https://fr.wikipedia.org/wiki/Compression_de_donn%C3%A9es)
3. [article wikipedia sur les compresseurs parfaits (sans perte & qui compressent strictement tout)](https://fr.wikipedia.org/wiki/Compression_de_donn%C3%A9es_universelle)
