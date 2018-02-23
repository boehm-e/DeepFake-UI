import QtQuick 2.9
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.1
import Process 1.0

Rectangle {
    id: to
    color: "#ffffff"

    DropZone {
        onFilepathChanged: {
            var video = filepath.replace("file://", "");
            var videoFile = video.toString().trim();
            processExtractImages.begin(videoFile);
            grid.folderPath = deepFake.toExtractDirectoryFile
        }
    }

    Process {
        id: processExtractImages

        function begin(videoFile) {
            processExtractImages.start('ffmpeg', ["-i", videoFile, deepFake.toExtractDirectory+"/%4d.jpg"]);
        }
        onStarted: head.headtextTo = "extracting images";
        onFinished: {
            head.headtextTo = "FINISHED extracting images"
            grid.folderPath = deepFake.toCropDirectoryFile
            processCropFaces.begin();
        }
    }

    Process {
        id: processCropFaces
        function begin() {
            processCropFaces.start("python3", [deepFake.faceswap, "extract", "-i", deepFake.toExtractDirectory, "-o",  deepFake.toCropDirectory]);
        }
        onStarted: head.headtextTo = "cropping faces";
        onReadyReadStandardOutput: {
            var std = readAll();
            var percent = parseFloat(std.toString().split('|')[0].trim())
            head.headtextTo = "cropping faces: "+percent+"%";
        }
        onFinished: {
            head.headtextTo = "FINISHED cropping faces"
        }
    }

    ImageGridView {
        id: grid
    }
}
