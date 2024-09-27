import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Function and Scope Demo")

    function min(a, b) {
        return Math.min(a,b)
    }

    Rectangle {
        id: mRectId
        width: min(500, 400)
        height: 100
        anchors.centerIn: parent
        color: "blue"
    }


}
