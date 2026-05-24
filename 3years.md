# 3 ans de travail sur la traduction française de Star Citizen : voici ce que j’ai appris

Cela fait maintenant 3 ans que je travaille sur la traduction française de Star Citizen. Je ne vais pas revenir sur absolument tout ce que j’ai pu voir au fil des années, mais je vais partager avec vous les points les plus importants.

Au début du projet, lorsque CIG a ajouté la possibilité d’utiliser des localisations personnalisées, tout semblait plutôt correct. J’ai donc pris l’initiative de récupérer le fichier contenant toutes les clés de langue avec les textes en VO, afin de le traduire entièrement.

J’étais loin d’imaginer qu’un simple fichier de langue pouvait être aussi mal géré.

## Le fonctionnement de base

Pour commencer, parlons des entrées en elles-mêmes.

Une entrée est composée d’un label, suivi d’un texte, séparés par un caractère spécifique. Dans ce cas précis, il s’agit du signe égal. Chaque ligne contient donc un label et le texte qui lui est associé.

Par exemple, le jeu appelle un label afin d’afficher le texte qui y est lié. Jusque-là, tout est normal.

Mais dès qu’on se penche un peu plus en profondeur sur le sujet, on découvre une gestion catastrophique, qui reflète malheureusement beaucoup d’autres problèmes présents dans le jeu.

## Une mauvaise utilisation des placeholders

Pour éviter de créer des entrées inutiles pour tout et n’importe quoi, on utilise ce qu’on appelle des placeholders. Ils prennent souvent ce type de format :

`~mission(itemName)`

Le problème, c’est que cette règle pourtant basique n’est même pas correctement respectée par le studio.

On peut par exemple trouver plusieurs entrées comme :

`2019_Ann_Sale_Day1=Expo-hall Day 01`

Alors qu’il aurait suffi d’utiliser un placeholder pour le numéro du jour :

`2019_Ann_Sale=Expo-hall Day ~mission(dayNumber)`

Au lieu d’avoir 12 entrées différentes, on aurait pu n’en avoir qu’une seule.

Et encore, ce n’est qu’un petit exemple. Imaginez ce que cela donne avec tous les RAB.

## Des textes identiques dupliqués partout

Ensuite, on retrouve aussi l’exact opposé : le même texte, exactement le même, attaché à plusieurs labels différents.

Cela ne sert absolument à rien, à part alourdir inutilement un fichier qui est déjà lourd pour un simple fichier de langue.

Exemple :

`Adagio_RepUI_Area=UEE`
`Advocacy_RepUI_Area=UEE`
`AmbassadorFlights_RepUI_Area=UEE`

Et ainsi de suite.

Au lieu de centraliser proprement ce type d’information, CIG multiplie les entrées redondantes, ce qui rend le fichier plus lourd, moins lisible et plus pénible à maintenir.

## Des labels appelés en jeu mais absents du fichier de langue

Il y a aussi un problème encore plus absurde.

Dans le jeu, pour faire le lien avec le fichier de langue, le système peut par exemple appeler :

`@Advocacy_RepUI_Area`

afin d’afficher le texte correspondant, ici :

`UEE`

Le problème, c’est qu’il existe énormément d’endroits dans le jeu, notamment sur la MobiGlas, où un label est appelé sans même exister dans le fichier de langue.

Par exemple :

`@port_DeskFlair`

Ce label est visible par tous les joueurs, mais il n’est attaché à aucun texte, tout simplement parce qu’il n’existe pas dans le fichier de langue. Résultat : le jeu affiche directement `@port_DeskFlair` au lieu d’un texte propre.

C’est un souci qui pourrait pourtant être évité très facilement.

## Des modifications de dernière minute

Autre phénomène très dérangeant pour ceux qui travaillent sur cette traduction : CIG a la fâcheuse tendance à modifier, ajouter ou supprimer des labels et des textes à la dernière minute.

Cela peut arriver juste avant une sortie LIVE, voire même pendant le cycle de vie d’une version LIVE.

Résultat : nous sommes obligés de vérifier en permanence si CIG n’a pas modifié, ajouté ou supprimé quelque chose, puis de réagir rapidement afin que les joueurs ne s’en rendent pas compte en jeu.

C’est une charge de travail supplémentaire qui pourrait largement être évitée avec une meilleure organisation en interne.

## Le problème des accents

Terminons avec quelque chose de particulièrement frustrant pour nous, francophones.

Comme vous le savez, les accents sont omniprésents dans notre langue. Le français est pourtant l’une des langues les plus parlées au monde, mais les accents ne sont toujours pas correctement pris en charge par certaines polices utilisées par le jeu.

De notre côté, dans la traduction, nous mettons les accents, car nous respectons la langue française.

Mais en jeu, les lettres accentuées peuvent être tronquées ou invisibles, ce qui crée parfois de vrais problèmes de lisibilité.

Ce problème spécifique est remonté depuis le début du projet. Et pourtant, qu’a fait CIG ?

Rien.

## Des problèmes qui dépassent la simple traduction

Tous les exemples que je donne ici sont des problèmes du quotidien pour les contributeurs de notre traduction française.

Et beaucoup de ces problèmes se retrouvent aussi dans d’autres parties du jeu, notamment le minage. L’outil communautaire Regolith en a d’ailleurs fait les frais, à cause de cette gestion typiquement “made in CIG”.

Personnellement, je trouve cela choquant qu’un simple fichier de langue soit aussi mal géré en interne.

Cela montre un énorme manque de rigueur, de logique et de méthodologie.

Si CIG gère déjà aussi mal un fichier de langue, on peut légitimement se demander comment sont gérés d’autres aspects bien plus complexes du jeu.

Le pire, dans tout ça, c’est que nous sommes obligés de subir ces problèmes de gestion pour continuer à fournir une traduction française propre aux joueurs francophones.

Merci d’avoir lu. J’espère que ce retour permettra de mettre en lumière certains problèmes souvent invisibles pour les joueurs.

Et un énorme merci à tous ceux qui soutiennent SCEFRA depuis ses débuts. Je pense notamment à Terada, Kennox, AirOne, Drakehinst, Onivoid, Ange, et à beaucoup d’autres.
