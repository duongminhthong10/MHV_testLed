import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    property int limit: 5
    property string text : textEdit.text
    Rectangle {
        height: parent.height
        anchors.fill: parent
        color: "transparent"
        border.color: "#ffc000"
        TextInput
        {
            id: textEdit
            anchors.fill: parent
            color: "#ffc000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: height * 0.3
            onTextChanged:
            {
                if (length > limit) {
                    remove (limit, length)
                }
            }
        }

    }
}

