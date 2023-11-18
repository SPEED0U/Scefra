#!/bin/python3

import sys
from lib import apply_translation,get_game_path,get_lutris_games,GameMode,GUI,GUIErrors,GUIException
from PyQt6.QtWidgets import QApplication,QWidget,QVBoxLayout,QLabel,QTableView,QPushButton,QMessageBox
from PyQt6 import QtCore
from PyQt6.QtCore import Qt

class GUIQT6(GUI):
    def display(self):
        self.application = QApplication(sys.argv)
        self.window = QWidget()
        self.window.setWindowTitle("Installation de la traduction française de Star Citizen")
        
        # Disposition horizontale
        layout=QVBoxLayout()

        layout.addWidget(QLabel("Jeux"))

        # Table de la liste des jeux lutris
        self.gameTable=QTableView()
        datas=self.get_datas_of_lutris_games()
        self.gameTable.setModel(TableModel(datas))
        self.gameTable.clicked.connect(self.select_line_of_table_game)
        self.gameTable.resizeColumnsToContents()
        layout.addWidget(self.gameTable)

        layout.addWidget(QLabel("Modes"))

        # Table de la liste des modes de Star Citizen
        self.modeTable=QTableView()
        modes_datas=GameMode.list_array()
        self.modeTable.setModel(TableModel(modes_datas))
        self.modeTable.clicked.connect(self.select_line_of_table_mode)
        self.modeTable.resizeColumnsToContents()
        layout.addWidget(self.modeTable)

        # Bouton Installation
        install_button=QPushButton("Installer/Mettre à jour")
        install_button.clicked.connect(self.install)

        layout.addWidget(install_button)

        self.window.setLayout(layout)

        # Dimensions de la fenêtre
        self.window.setFixedSize(490,690)

        self.window.show()
        self.application.exec()
    
    def select_line_of_table_game(self,index):
        row=index.row()
        model=index.model()
        columnsTotal=model.columnCount(None)

        for i in range(columnsTotal):
            self.gameTable.selectRow(row)
    
    def select_line_of_table_mode(self,index):
        row=index.row()
        model=index.model()
        columnsTotal=model.columnCount(None)

        for i in range(columnsTotal):
            self.modeTable.selectRow(row)
    
    def get_directory(self):
        index = self.gameTable.selectedIndexes()

        if len(index)==0:
            raise GUIException(GUIErrors.NO_DIRECTORY)
        
        return index[2].data(0)

    def get_mode(self):
        index = self.modeTable.selectedIndexes()

        if len(index)==0:
            raise GUIException(GUIErrors.NO_MODE)
        
        return int(index[0].data(0))

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
