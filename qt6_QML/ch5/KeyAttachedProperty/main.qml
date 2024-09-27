import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Keys Attached Property")

    Rectangle {
        id: containedRect
        anchors.centerIn: parent
        width: 300; height: 50; color: "dodgerblue"
        focus: true

        Keys.onDigit5Pressed: function(event) {
            event.accepted = true //만약 event.accepted = false라고 한다면 특수 처리기가 처리를 한 후 다시 일반 처리기로 넘어가는 것을 허락하는 것이다.constructor
            if(event.modifiers === Qt.ControlModifier) {
                console.log("Pressed Control + 5")
            } else {
                console.log("Pressed regular + 5")
            }
        }

        Keys.onPressed: function(event) {
            if((event.key === Qt.Key_5) && (event.modifiers & Qt.ControlModifier)) {
                console.log("General Signal: Pressed Control + 5")
            } else if (event.key === Qt.Key_5) {
                console.log("General Signal: Key 5 was pressed along.")
            }
        }
    }
}
