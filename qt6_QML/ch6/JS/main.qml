import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("JS")

    Rectangle {
        id: containerRectId
        width: getHeight()  // JS in function
        height: 100
        color: x > 300 ? "red" : "green"    // property binding

        //JS in signal DragHandler
        onXChanged: {
            console.log("Current value of x: " + x)
        }

        // Custom function
        function getHeight()
        {
            return height * 2
        }
    }

    MouseArea {
        anchors.fill: parent
        drag.target: containerRectId
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: parent.width - containerRectId.width
    }
}
