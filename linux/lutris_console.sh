#!/bin/python3

from lib import apply_translation,get_game_path,get_lutris_games,GameMode

def display_list(left,center,right):
    print(f"{left : <20}{center : ^15}{right : >40}")

def display_game_mode(left,right):
    print(f"{left : <20}{right : <20}")

def select_lutris_game():
    games=get_lutris_games()
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
    if i!=GameMode.LIVE.value and i!=GameMode.PTU.value:
        return select_game_mode()
    return i

game=select_lutris_game()
mode=select_game_mode()
path=get_game_path(game["directory"],mode)
apply_translation(path)