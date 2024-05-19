import json
import subprocess
from enum import Enum
import requests
from pathlib import Path
from configobj import ConfigObj

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
    res=Path(directory,"drive_c/Program Files/Roberts Space Industries/StarCitizen")
    match mode:
        case GameMode.TECH_PREVIEW.value:
            return Path(res,"TECH-PREVIEW")
        case _:
            return Path(res,mode.name)

class MyEnum(Enum):
    @classmethod
    def list(cls):
        return list(map(lambda c:c, cls))
    @classmethod
    def list_array(cls):
        return list(map(lambda c:[c.value,c.name],cls))
    @classmethod
    def name_list(cls):
        return list(map(lambda c:c.name,cls))
    @classmethod
    def from_name(cls,name):
        for item in cls.list():
             if item.name==name:
                return item
        raise Exception('Incorrect Name')
    @classmethod
    def from_value(cls,value):
        for item in cls.list():
            if item.value==value:
                return item
        raise Exception('Incorrect Value')

class LutrisVersion(MyEnum):
    flatpak = 'Flatpak'
    system = 'Système'

class GameMode(MyEnum):
    LIVE = 1
    PTU = 2
    TECH_PREVIEW = 3
    EPTU = 4

def lutris_flatpak_pkg():
    return "net.lutris.Lutris"

def get_lutris_versions():
    res=[]
    if has_system_lutris():
        res.append(LutrisVersion.system)
    if has_flatpak_lutris():
        res.append(LutrisVersion.flatpak)
    return res

def command_exists(command):
    return subprocess.run(['which',command],capture_output=True).returncode==0

def get_flatpak_pkgs():
    lines=subprocess.run(['flatpak','list','--columns=application'],capture_output=True).stdout.decode('utf-8').split('\n')
    lines.pop()
    return lines

def has_flatpak_lutris():
    if not command_exists('flatpak'):
        return False
    return lutris_flatpak_pkg() in get_flatpak_pkgs()

def has_system_lutris():
    return command_exists('lutris')

def get_lutris_gamelist(command):
    command.extend(['-loj'])
    return json.loads(subprocess.run(command,capture_output=True).stdout)

def get_flatpak_lutris_games():
    return get_lutris_gamelist(['flatpak','run',lutris_flatpak_pkg()])

def get_system_lutris_games():
    return get_lutris_gamelist(['lutris'])

def get_lutris_games(version):
    if version==LutrisVersion.flatpak:
        if has_flatpak_lutris():
            return get_flatpak_lutris_games()
    else:
        if has_system_lutris():
            return get_system_lutris_games()
    return []

def write_user_cfg(directory):
    file=Path(directory,"user.cfg")
    config=ConfigObj(file.as_posix())
    config["g_language"]="french_(france)"
    config.write()

class GUI:
    def __init__(self):
        self.versions=get_lutris_versions()
    def display(self):
        raise Exception("Méthode non implémenté")
    def get_directory(self):
        raise Exception("Méthode non implémenté")
    def get_mode(self):
        raise Exception("Méthode non implémenté")
    def get_selected_version(self):
        raise Exception("Méthode non implémenté")
    def get_version(self):
        if len(self.versions)==1:
            return self.versions[0]
        return self.get_selected_version()
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

    def display_error(self,message):
        raise Exception("Méthode non implémenté")
    
    def display_info(self,message):
        raise Exception("Méthode non implémenté")
    
    def get_versions_name(self):
        return list(map(lambda c: c.value,self.versions))

class GUIErrors(Enum):
    NO_DIRECTORY = 1
    NO_MODE = 2


class GUIException(Exception):
    def __init__(self,error):
        super().__init__()
        self.error=error