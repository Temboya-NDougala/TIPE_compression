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

+ [ ] implementer ecriture bit-a-bit sur un fichier
+ [ ] Huffman
  + [ ] implementer arbres et tas min

## Notes pour la bibliographie commentée

+ Il n'existe pas d'algorithmes de codage parfait, ie sans perte et qui
    compresse strictement tous les mots [2.3](#source_2.3)
  + Plus exactement, pour tout algorithme lossless, on a 3 certitudes :

    1. Il existe un mot dans la version compression est de longueur
        supérieure ou égale au mot initial

    2. S'il existe un mot strictement compressé, il en existe au moins un
        autre dont la version compressée est strictement plus longue que
        le mot initial
    3. Les itérations du compresseurs sur un mot de départ quelconque
        aboutissent à l'un des deux cas suivant
        + soit on a une boucle de mots
        + soit la longueur des mots decompressés peut devenir
            arbitrairement grande
+ Cependant, dans la pratique, les fichiers ne sont pas totalement aléatoires,
    et il existe des algorithmes spécialisés qui utilisent les informations
    fournies par le contexte de (dé)compression (le type de fichier à
    décompresser, typiquement). [2.3](#source_2.3)

## Sources

1. [video de vulgarisation sur les ondelettes (potentiellement inutilisée)](https://youtu.be/vpmlGMZSpvQ?si=35RCm1T92-lWqZgx)<a id = "source_1"></a>

2. articles wikipedia & affiliés<a id = "source_2"></a>
    1. [compression de donnees](https://fr.wikipedia.org/wiki/Compression_de_donn%C3%A9es) <a id = "source_2.1"></a>
    2. [compresseurs parfaits](https://fr.wikipedia.org/wiki/Compression_de_donn%C3%A9es_universelle) <a id = "source_2.2"></a>
    3. [complexité de Kolmogoroff](https://en.wikipedia.org/wiki/Kolmogorov_complexity) <a id = "source_2.3"></a>
    4. [NCD](https://en.wikipedia.org/wiki/Normalized_compression_distance)<a id = "source_2.4"></a>
    5. [wikibook sur la compression de données](https://en.wikibooks.org/wiki/Data_Compression) <a id = "source_2.5"></a>
    6. [entropie (théorie de l'information)](https://en.wikipedia.org/wiki/Entropy_(information_theory)) <a id = "source_2.6"></a>
3. sources téléchargées
   1. [cours de l'école polytechnique sur la théorie de l'information](/documentation/cours_intro_thr_info_X.pdf) <a id = "source_3.1"></a>
   2. [etat de l'art sur la compression de donnees](/documentation/state_of_the_art_in_data_compression.pdf) <a id = "source_3.2"></a>
   3. [avancées de la compression grâce à l'IA](/documentation/compression_AI_era.pdf) <a id = "source_3.3"></a>
   4. [cours sur le codage arithmétique](/documentation/cours_codage_arithmetique.pdf) <a id = "source_3.4"></a>
   5. [introduction à la théorie de l'information](/documentation/info_thr_intro.pdf) <a id = "source_3.5"></a>
   6. [introduction à la compression de données](/documentation/intro_data_compression.pdf) <a id = "source_3.6"></a>
