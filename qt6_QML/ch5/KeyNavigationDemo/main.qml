import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Key Navigation Demo")

    Grid {
        anchors.centerIn: parent
        columns: 2

        Rectangle {
            id: topLeft
            width: 100; height: width
            border.color: "lightgrey"
            color: focus? "red" : "lightgrey"
            focus: true
            KeyNavigation.right: topRight
            KeyNavigation.down: bottomLeft
        }

        Rectangle {
            id: topRight
            width: 100; height: width
            border.color: "lightgrey"
            color: focus? "red" : "lightgrey"
            KeyNavigation.left: topLeft
            KeyNavigation.down: bottomRight
        }

        Rectangle {
            id: bottomLeft
            width: 100; height: width
            border.color: "lightgrey"
            color: focus? "red" : "lightgrey"
            KeyNavigation.right: bottomRight
            KeyNavigation.up: topLeft
        }


        Rectangle {
            id: bottomRight
            width: 100; height: width
            border.color: "lightgrey"
            color: focus? "red" : "lightgrey"
            KeyNavigation.left: bottomLeft
            KeyNavigation.up: topRight
        }
    }
}
