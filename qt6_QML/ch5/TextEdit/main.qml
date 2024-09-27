import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("TextEdit Demo")

    TextEdit {
        id: textEditId
        wrapMode: TextEdit.Wrap
        width: 480
        text: " 우리의 소원은 통일 꿈에도 소원은 통일 이나라 살리는 통일 통일이여 오라
학교종이 땡땡땡 어서 모이자, 선생님이 우리를 기다리신다."
        font.family: "Helvetica"
        font.pointSize: 20
        color: "blue"
        focus: true
    }

    Rectangle {
        id: mRectId
        width: 240; height: 100
        color: "red"
        anchors.top: textEditId.bottom
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("The new text is: " + textEditId.text)
            }
        }
    }
}
