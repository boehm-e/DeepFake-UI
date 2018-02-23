import QtQuick 2.9
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.1
import Process 1.0

Rectangle {
    id: from
    color: "#ffffff"

    DropZone {
        onFilepathChanged: {
            var video = filepath.replace("file://", "");
            var videoFile = video.toString().trim();
            processExtractImages.begin(videoFile);
            grid.folderPath = deepFake.fromExtractDirectoryFile
        }
    }

    Process {
        id: processExtractImages

        function begin(videoFile) {
            processExtractImages.start('ffmpeg', ["-i", videoFile, deepFake.fromExtractDirectory+"/%4d.jpg"]);
        }
        onStarted: head.headtextFrom = "extracting images";
        onFinished: {
            head.headtextFrom = "FINISHED extracting images"
            grid.folderPath = deepFake.fromCropDirectoryFile
            processCropFaces.begin();
        }
    }

    Process {
        id: processCropFaces
        function begin() {
            processCropFaces.start("python3", [deepFake.faceswap, "extract", "-i", deepFake.fromExtractDirectory, "-o",  deepFake.fromCropDirectory]);
        }
        onStarted: head.headtextFrom = "cropping faces";
        onReadyReadStandardOutput: {
            var std = readAll();
            var percent = parseFloat(std.toString().split('|')[0].trim())
            head.headtextFrom = "cropping faces: "+percent+"%";
        }
        onFinished: {
            head.headtextFrom = "FINISHED cropping faces"
        }
    }

    ImageGridView {
        id: grid
    }
}
