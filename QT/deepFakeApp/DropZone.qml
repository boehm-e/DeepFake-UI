import QtQuick 2.9
import QtQuick.Window 2.2

Rectangle {
    id: dropzone
    anchors.fill: parent
    color: "transparent"
    property string filepath
    DropArea {
        anchors.fill: parent
        keys: ["text/plain"]
        onEntered: {
            dropzone.color = "#eaeaea"
        }
        onExited: {
            dropzone.color = "#ffffff"
        }
        onDropped: {
            dropzone.color = "#ffffff"
            if (drop.hasText) {
                if (drop.proposedAction == Qt.MoveAction || drop.proposedAction == Qt.CopyAction) {
                    filepath = drop.text;
                    drop.acceptProposedAction()
                }
            }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: draggable
    }
    Item {
        id: draggable
        anchors.fill: parent
        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: 0
        Drag.hotSpot.y: 0
        Drag.dragType: Drag.Automatic
        Drag.onDragStarted: {
        }
        Drag.onDragFinished: {
            if (dropAction == Qt.MoveAction) {
                item.display = ""
            }
        }
    }
}
