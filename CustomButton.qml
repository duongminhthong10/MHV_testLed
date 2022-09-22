import QtQuick 2.9
import QtQuick.Controls 2.15

Button {
    background: Rectangle {
        anchors.fill: parent
        border.width: (parent.pressed || parent.checked) ? 2 : 1
        border.color: "#ffc000"
        color: parent.pressed ? "#CCCC33" : "transparent"
        opacity: enabled ? 1.0 : 0.3
        //color: "transparent"
        Timer {
            id: refresh
            interval: 200
            onTriggered: {
                parent.update()
            }
        }
        Component.onCompleted: refresh.start()
    }
    contentItem: Text {
        text: parent.text
        font: parent.font
        color: "#ffc000"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    font.family: "Nunito Sans"
    font.bold: checked ? true : false
    font.pixelSize: height * 0.5
}
