import QtQuick 2.0
import Process 1.0

Rectangle {
    MouseArea {
        anchors.fill: parent
        onClicked: {
            processTrain.begin();
        }
    }


    Rectangle {
        width: parent.width / 2;
        height: parent.height;
        Text {
            id: epoch
            anchors.centerIn: parent;
        }
    }

    Rectangle {
        id: stopTraining
        anchors.right: parent.right
        width: parent.width / 2;
        height: parent.height;
        Text {
            anchors.centerIn: parent;
            text: "STOP TRAINING"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("clicked")
            }
        }
    }

    Process {
        id: processTrain
        function begin() {
            processTrain.start("python3", [deepFake.faceswap, "train", "-m", deepFake.trainDirectory, "-A", deepFake.fromCropDirectory, "-B",  deepFake.toCropDirectory]);
        }
        onStarted: {
            head.headtextFrom = "start training";
        }
        onFinished: {
            head.headtextFrom = "FINISHED training"
        }
        onReadyReadStandardOutput: {
            var std = readStdOut().toString().split('\n');
            for (var i=0; i<std.length; i++) {
                var line = std[i].toString();
                console.log(" : : : : : ", line)
                if (line.indexOf("deepfake") > -1) {
                    if (line.split("|")[1] == "SAVING") {
                        console.log("====== SAVING");
                    }
                    if (line.split("|")[1] == "EPOCH") {
                        var _epoch = line.split("|")[2];
                        console.log("====== EPOCH : " + _epoch);
                        epoch.text = "epoch : " + _epoch;
                    }
                }

            }

        }
        onError: head.headtextFrom = error
    }
}
