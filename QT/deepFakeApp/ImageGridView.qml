import QtQuick 2.0
import Qt.labs.folderlistmodel 2.1

Rectangle {
    anchors.fill: parent;
    property string folderPath
    color: "transparent"

    FolderListModel {
        id: folderModel
        folder: folderPath
        nameFilters: ["*.jpg"]
    }

    Component {
        id: imageDelegate
        Item {
            width: grid.cellWidth; height: grid.cellHeight
            Column {
                anchors.fill: parent
                Image { source: folderModel.folder + "/" + fileName;width: parent.width; fillMode:Image.PreserveAspectFit; anchors.horizontalCenter: parent.horizontalCenter }
            }
        }
    }

    GridView {
        id: grid
        anchors.fill: parent
        cellWidth: parent.width / 4; cellHeight: cellWidth

        model: folderModel
        delegate: imageDelegate
        focus: true
    }

}
