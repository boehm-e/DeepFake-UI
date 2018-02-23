import QtQuick 2.9
import QtQuick.Window 2.2

Rectangle {
    width: parent.width
    height: 75;
    color: "#45aaf4"

    property string headtextFrom: "drag file"
    property string headtextTo: "drag file"

    Text {
        text: headtextFrom
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 25
        font.pointSize: 24
        color: "white"
    }

    Text {
        text: headtextTo
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 25
        font.pointSize: 24
        color: "white"
    }
}
