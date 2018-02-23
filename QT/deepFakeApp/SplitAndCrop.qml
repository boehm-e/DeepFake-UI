import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Rectangle {
    color: "orange";
    anchors.fill: parent
    id: test
    From {
        id: from
        width: parent.width / 2
        height: parent.height - head.height
//        anchors.top: head.bottom
    }

    Divider {
        width: 2
        anchors.bottom: train.top
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
    }

    To {
        id: to
        width: parent.width / 2
        height: parent.height - head.height
        anchors.left: from.right
    }

    Divider {
        anchors.bottom: train.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: train.width;
        height: 2
    }

    Train {
        id: train
        width: parent.width
        height: (parent.height - head.height) / 4
        anchors.bottom: parent.bottom
    }
}
