import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("DelayButton")

    ColumnLayout {
        width: parent.width
        spacing: 40

        Label {
            width: parent.width
            wrapMode: Label.Wrap
            Layout.fillWidth: true
            text: "DelayButton. Use it when you want to prevent accidental clicks"
            font.pointSize: 15
        }

        DelayButton {
            property bool activated: false
            text: "DelayButton"
            Layout.fillWidth: true
            delay: 1000

            onPressed: {
                if(activated === true) {
                    console.log("Button is Clicked. Carrying out the task")
                    activated = false;
                }
            }
            onActivated: {
                console.log("Button Activated")
                activated = true
            }
            onProgressChanged: {
                console.log(progress)
            }
        }
    }

}
