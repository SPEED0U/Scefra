#!/bin/python3

from lib import apply_translation,get_game_path,get_lutris_games,get_lutris_versions,GameMode,LutrisVersion

def display_list(left,center,right):
    print(f"{left : <20}{center : ^15}{right : >40}")

def display_game_mode(left,right):
    print(f"{left : <20}{right : <20}")

def select_lutris_version():
    versions=get_lutris_versions()

    if len(versions)==0:
        raise Exception("Lutris n'est pas installé")
    elif len(versions)==1:
        return versions[0]

    display_list("ID","Version","")
    i=1
    versions=list(map(lambda c:LutrisVersion.from_name(c),versions))
    for version in versions:
        display_list(str(i),version,"")

    i=int(input("Entrez l'ID de la version de Lutris: "))

    if i>len(versions) or i<1:
        return select_lutris_version()
    
    return LutrisVersion.from_value(versions[i-1])

def select_lutris_game(version):
    games=get_lutris_games(version)

    if len(games)==0:
        raise Exception("Il n'y a pas de jeux")

    display_list("ID","Nom du jeu","Répertoire")
    for game in games:
        display_list(str(game["id"]),game["name"],game["directory"])
        
    i=int(input("Entrez l'ID du jeu Star Citizen: "))
    for game in games:
        if game["id"]==i:
            return game
    print("ID invalide")
    return select_lutris_game()

def select_game_mode():
    for mode in GameMode.list():
        display_game_mode(str(mode.value),mode.name)
    i=int(input("Sélectionnez un ID correspondant au mode de Star Citizen: "))
    if i!=GameMode.LIVE.value and i!=GameMode.PTU.value and i!=GameMode.TECH_PREVIEW.value and i!=GameMode.EPTU.value:
        return select_game_mode()
    return i

version=select_lutris_version()
game=select_lutris_game(version)
mode=select_game_mode()
path=get_game_path(game["directory"],mode)
apply_translation(path)