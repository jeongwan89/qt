import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("MQTT Client")

    RowLayout {
        anchors.fill: parent
        spacing: 20
        anchors.margins: 20 // padding 대신 margins 사용

        ColumnLayout {
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width * 0.4
            spacing: 10

            TextField {
                id: serverInput
                placeholderText: qsTr("MQTT Server")
                text: "192.168.0.24" // 기본값 설정
                Layout.fillWidth: true
            }

            TextField {
                id: portInput
                placeholderText: qsTr("Port")
                text: "1883" // 기본값 설정
                Layout.fillWidth: true
                inputMethodHints: Qt.ImhDigitsOnly
            }

            TextField {
                id: usernameInput
                placeholderText: qsTr("Username")
                text: "farmmain" // 기본값 설정
                Layout.fillWidth: true
            }

            TextField {
                id: passwordInput
                placeholderText: qsTr("Password")
                text: "eerrtt" // 기본값 설정
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }

            Button {
                id: connectButton
                text: qsTr("Connect")
                Layout.fillWidth: true
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

        ColumnLayout {
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width * 0.6
            spacing: 10
            Layout.alignment: Qt.AlignCenter // 중앙 정렬 추가

            Label {
                text: qsTr("Temperature")
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter // 중앙 정렬 추가
            }

            Dial {
            // CircularGauge {  
                id: temperatureDial
                from: 0
                to: 100
                value: 0
                stepSize: 1
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter // 중앙 정렬 추가
                Layout.preferredHeight: 200
            }

            Label {
                id: temperatureText
                text: qsTr("Current Temperature: ") + temperatureDial.value.toFixed(1) + " °C"
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter // 중앙 정렬 추가
            }
        }
    }

    function handleMessageReceived(message: variant, topic: variant) {
        // MQTT 메시지를 수신하면 다이얼 값을 업데이트
        if (topic === "Sensor/GH1/Center/Temp") {
            temperatureDial.value = parseFloat(message);
            temperatureText.text = qsTr("Current Temperature: ") + temperatureDial.value.toFixed(1) + " °C";
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
        onMessageReceived: function(message, topic) {
            handleMessageReceived(message, topic);
        }
    }
}
