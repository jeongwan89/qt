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
            width: parent.width * .8
        }

        TextField {
            id: portInput
            placeholderText: qsTr("Port")
            width: parent.width * .8
            inputMethodHints: Qt.ImhDigitsOnly
        }

        TextField {
            id: usernameInput
            placeholderText: qsTr("Username")
            width: parent.width * .8
        }

        TextField {
            id: passwordInput
            placeholderText: qsTr("Password")
            echoMode: TextInput.Password
            width: parent.width * .8
        }

        Button {
            id: connectButton
            text: qsTr("Connect")
            onClicked: {
                if (mqttClient.state === 0) { // QMqttClient::Disconnected 상태
                    mqttClient.hostname = serverInput.text
                    mqttClient.port = parseInt(portInput.text)
                    mqttClient.username = usernameInput.text
                    mqttClient.password = passwordInput.text
                    mqttClient.connectToHost()
                } else {
                    mqttClient.disconnectFromHost()
                }
            }
        }
    }

    Connections {
        target: mqttClient
        onConnected: {
            connectButton.text = qsTr("Disconnect")
        }
        onDisconnected: {
            connectButton.text = qsTr("Connect")
        }
    }
}
