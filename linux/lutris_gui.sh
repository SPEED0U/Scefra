#!/bin/python3

import sys
from lib import apply_translation,get_game_path,get_lutris_games,GameMode,GUI,GUIErrors,GUIException,LutrisVersion
from PyQt6.QtWidgets import QApplication,QWidget,QVBoxLayout,QLabel,QTableView,QPushButton,QMessageBox,QComboBox
from PyQt6 import QtCore
from PyQt6.QtCore import Qt

class GUIQT6(GUI):
    def display(self):
        self.application = QApplication(sys.argv)
        self.window = QWidget()
        self.window.setWindowTitle("Installation de la traduction française de Star Citizen")

        # Disposition horizontale
        layout=QVBoxLayout()

        self.versionLabel=QLabel("Version de Lutris")
        layout.addWidget(self.versionLabel)

        # Table de la version de lutris
        self.lutrisVersion=self.create_combobox(layout,self.get_versions_name())
        self.lutrisVersion.currentTextChanged.connect(self.sync_table_game_to_table_version)

        layout.addWidget(QLabel("Jeux"))

        self.gameTable=self.create_table(layout,self.get_datas_of_lutris_games(LutrisVersion.system))
        self.gameTable.clicked.connect(self.select_line_of_table_game)
        self.flatpakGames=self.create_table(layout,self.get_datas_of_lutris_games(LutrisVersion.flatpak))
        self.flatpakGames.clicked.connect(self.select_line_of_flatpak_games)

        if len(self.versions)==0:
            raise Exception("Lutris n'est pas installé")
        elif len(self.versions)==1:
            self.versionLabel.hide()
            self.lutrisVersion.hide()
            if self.versions[0]==LutrisVersion.system:
                self.flatpakGames.hide()
            else:
                self.gameTable.hide()
        else:
            self.flatpakGames.hide()

        layout.addWidget(QLabel("Modes"))

        # Table de la liste des modes de Star Citizen
        self.modeTable=self.create_combobox(layout,GameMode.name_list())

        # Bouton Installation
        install_button=QPushButton("Installer/Mettre à jour")
        install_button.clicked.connect(self.install)

        layout.addWidget(install_button)

        self.window.setLayout(layout)

        # Dimensions de la fenêtre
        self.window.setFixedSize(490,690)

        self.window.show()
        self.application.exec()

    def create_table(self,layout,datas):
        table=QTableView()
        table.setModel(TableModel(datas))
        table.resizeColumnsToContents()
        layout.addWidget(table)
        return table

    def create_combobox(self,layout,datas):
        combobox=QComboBox()
        combobox.addItems(datas)
        layout.addWidget(combobox)
        return combobox


    def sync_table_game_to_table_version(self,index):
        if self.get_version()==LutrisVersion.flatpak:
            self.flatpakGames.show()
            self.gameTable.hide()
        else:
            self.flatpakGames.hide()
            self.gameTable.show()

    def select_line_of_table_game(self,index):
        row=index.row()
        model=index.model()
        columnsTotal=model.columnCount(None)

        for i in range(columnsTotal):
            self.gameTable.selectRow(row)

    def select_line_of_flatpak_games(self,index):
        row=index.row()
        model=index.model()
        columnsTotal=model.columnCount(None)

        for i in range(columnsTotal):
            self.flatpakGames.selectRow(row)

    def get_directory(self):
        if self.get_version()==LutrisVersion.system:
            index = self.gameTable.selectedIndexes()

            if len(index)==0:
                raise GUIException(GUIErrors.NO_DIRECTORY)
            return index[2].data(0)
        else:
            index = self.flatpakGames.selectedIndexes()

            if len(index)==0:
                raise GUIException(GUIErrors.NO_DIRECTORY)
            return index[2].data(0)

    def get_mode(self):
        return GameMode.from_name(self.modeTable.currentText())

    def get_selected_version(self):
        return LutrisVersion.from_value(self.lutrisVersion.currentText())

    def display_text_message(self,message,icon):
        dialog=QMessageBox(self.window)

        # définition de la fenêtre de message
        dialog.setText(message)
        dialog.setStandardButtons(QMessageBox.StandardButton.Ok)
        dialog.setIcon(icon)
        dialog.exec()

    def display_error(self,message):
        self.display_text_message(message,QMessageBox.Icon.Warning)

    def display_info(self,message):
        self.display_text_message(message,QMessageBox.Icon.Information)

    def get_datas_of_lutris_games(self,version):
        res=[]
        for game in get_lutris_games(version):
            res.append([game["id"],game["name"],game["directory"]])
        if len(res)==0:
            return [["","",""]]
        return res

class TableModel(QtCore.QAbstractTableModel):
    def __init__(self, data):
        super(TableModel, self).__init__()
        self._data = data

    def data(self, index, role):
        if role == Qt.ItemDataRole.DisplayRole:
            value = self._data[index.row()][index.column()]

            if isinstance(value, str):
                return '%s' % value

            return value

    def rowCount(self, index):
        return len(self._data)

    def columnCount(self, index):
        return len(self._data[0])

app=GUIQT6()
app.display()
