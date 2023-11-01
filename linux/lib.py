import json
import subprocess
from enum import Enum
import requests
from pathlib import Path

def apply_translation(path):
    if not path.is_dir():
        raise Exception("Ce répertoire n'existe pas")
    
    translation=get_translation()
    write_user_cfg(path)
    datasLocalization=Path(path,"data/Localization/french_(france)")
    if not datasLocalization.is_dir():
        datasLocalization.mkdir(parents=True)
        print("Dossier crée")
    
    file=Path(datasLocalization,"global.ini")

    if not file.is_file():
        file.touch()
        print("Fichier global.ini crée")

    # Permet d'écrire le fichier avec le BOM
    file.write_text(translation,encoding="utf-8-sig")
    print("Fichier global.ini modifié")

def get_translation():
    translation_request=requests.get("https://raw.githubusercontent.com/SPEED0U/StarCitizenTranslations/main/french_(france)/global.ini")
    if not translation_request.ok:
        raise Exception("La requête pour récupérer le contenu de la traduction n'a pas fonctionné")
    print("Traduction récupéré")
    return translation_request.text

def get_game_path(directory,mode):
    res=directory+"/drive_c/Program Files/Roberts Space Industries/StarCitizen"
    match mode:
        case GameMode.LIVE.value:
            return Path(res,"LIVE")
        case GameMode.PTU.value:
            return Path(res,"PTU")

class GameMode(Enum):
    LIVE = 1
    PTU = 2
    
    @classmethod
    def list(cls):
        return list(map(lambda c:c, cls))

    @classmethod
    def list_array(cls):
        return list(map(lambda c:[c.value,c.name],cls))

def get_lutris_games():
    return json.loads(subprocess.run(['lutris','-loj'],capture_output=True).stdout)

def write_user_cfg(directory):
    add="g_language = french_(france)"
    file=Path(directory,"user.cfg")
    res=""

    if file.is_file():
        res=file.read_text()+"\n"
    else:
        file.touch()
        print("Fichier user.cfg crée")
    
    if res.find(add)==-1:
        res+=add
        file.write_text(res)
        print("Fichier user.cfg modifié")

class GUI:
    def __init__(self):
        self.lutris_games=get_lutris_games()
    def display(self):
        raise Exception("Méthode non implémenté")
    def get_directory(self):
        raise Exception("Méthode non implémenté")
    def get_mode(self):
        raise Exception("Méthode non implémenté")
    def install(self):
        try:
            path=get_game_path(self.get_directory(),self.get_mode())
            apply_translation(path)
            self.display_info("Traduction terminé")
        except GUIException as e:
            match e.error:
                case GUIErrors.NO_DIRECTORY:
                    self.display_error("Le répertoire du jeu n'a pas été sélectionné")
                case GUIErrors.NO_MODE:
                    self.display_error("Le mode du jeu n'a pas été sélectionné")
        except Exception as e:
            self.display_error(e.args[0])
    
    def get_datas_of_lutris_games(self):
        res=[]
        for game in self.lutris_games:
            res.append([game["id"],game["name"],game["directory"]])
        return res

    def display_error(self,message):
        raise Exception("Méthode non implémenté")
    
    def display_info(self,message):
        raise Exception("Méthode non implémenté")

class GUIErrors(Enum):
    NO_DIRECTORY = 1
    NO_MODE = 2


class GUIException(Exception):
    def __init__(self,error):
        super().__init__()
        self.error=error