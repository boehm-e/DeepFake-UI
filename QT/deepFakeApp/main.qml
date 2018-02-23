import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.3


Window {
    id: deepFake
    visible: true
    width: 640
    height: 480

    property string clonePath: "/home/erwan/Desktop/PROJECTS/MY_DEEP_FAKE"
    property string faceswap: clonePath + "/faceswap/faceswap.py"

    //    FROM
    property string fromExtractDirectory: clonePath+"/data/model_A"
    property string fromExtractDirectoryFile: "file://"+clonePath+"/data/model_A"
    property string fromCropDirectory: clonePath+"/data/model_A/aligned"
    property string fromCropDirectoryFile: "file://"+clonePath+"/data/model_A/aligned"

    //    TO
    property string toExtractDirectory: clonePath+"/data/model_B"
    property string toExtractDirectoryFile: "file://"+clonePath+"/data/model_B"
    property string toCropDirectory: clonePath+"/data/model_B/aligned"
    property string toCropDirectoryFile: "file://"+clonePath+"/data/model_B/aligned"

    //    TRAIN
    property string trainDirectory: clonePath+"/data/models"
    Head {
        id: head
        z:5
    }

    SplitAndCrop {
        id: splitAndCrop
//        anchors.fill: parent;
        width: parent.width
        height: parent.height - head.height
        anchors.top: head.bottom
        visible: true;
    }

    TrainAndConvert {
        id: trainAndConvert
        anchors.fill: parent;
        visible: !splitAndCrop.visible
    }

}
