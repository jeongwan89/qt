import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("MQTT Client")

    Column {
        anchors.centerIn: parent
        spacing: 10

        TextField {
            id: serverInput
            placeholderText: qsTr("MQTT Server")
            width: parent.width * 0.8
        }

        TextField {
            id: usernameInput
            placeholderText: qsTr("Username")
            width: parent.width * 0.8
        }

        TextField {
            id: passwordInput
            placeholderText: qsTr("Password")
            echoMode: TextInput.Password
            width: parent.width * 0.8
        }

        Button {
            text: qsTr("Connect")
            onClicked: {
                // Handle connection logic here
                console.log("Server:", serverInput.text)
                console.log("Username:", usernameInput.text)
                console.log("Password:", passwordInput.text)
            }
        }
    }
}
