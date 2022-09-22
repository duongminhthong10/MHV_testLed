import QtQuick 2.9

Item {
    /*Key input*/
    Keys.onReleased:
    {
        if (event.key === Qt.Key_Backspace)
        {
            inPutFloor.text = inPutFloor.text.substr(0,inPutFloor.text.length - 1)
        }
        else
        {
            inPutFloor.text = inPutFloor.text + event.text
        }
    }
    /* Back ground */
    Image {
        anchors.fill: parent
        source: "image/bg_main.png"
    }
    BackButton {
        id: btnBack
        anchors { bottom: parent.bottom; bottomMargin: wH * 0.02; right: parent.right; rightMargin: wW * 0.02 }
    }
    HomeButton {
        anchors {bottom: parent.bottom; bottomMargin: wH * 0.02; right: btnBack.left; rightMargin: wW * 0.01}
    }
    /*Header*/
    Text {
        text: "TÒA " + blockName
        color: "#ffc000"
        font.pixelSize: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: wW * 0.06

    }
    /*main view*/
    Item {
        anchors.centerIn: parent
        width: wW * 0.6
        height: wH * 0.6
        Column {
            anchors.centerIn: parent
            spacing: 10
            Row {
                spacing: 10
                Item {
                    width: wW * 0.3
                    height: wH * 0.06
                    Rectangle {
                        id: rec
                        height: parent.height
                        anchors.fill: parent
                        color: "transparent"
                        border.color: "#ffc000"
                    }
                    TextInput
                    {
                        id: inPutFloor
                        property int limit: 5
                        anchors.fill: parent
                        color: "#ffc000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: rec.height * 0.3
                        onTextChanged:
                        {
                            if (length > limit) {
                                remove (limit, length)
                            }
                        }
                    }

                }
                CustomButton {
                    height: wH * 0.06
                    width: wW * 0.05
                    text: "ON"
                    onClicked: {
                        console.log(inPutFloor.text)
                        inPutFloor.text = ""
                    }
                }
                CustomButton {
                    height: wH * 0.06
                    width: wW * 0.05
                    text: "OFF"
                }
            }
            Grid
            {
                spacing: 10
                columns: 3
                Repeater {
                    model: 10
                    CustomButton {
                        width: 0.133 * wW
                        height: 0.1 * wH
                        text: index
                        onClicked:
                        {
                            inPutFloor.text = inPutFloor.text + index
                        }
                    }
                }
                CustomButton {
                    width: 0.133 * wW
                    height: 0.1 * wH
                    text: "DEL"
                    onClicked:
                    {
                        inPutFloor.text = inPutFloor.text.substr(0,inPutFloor.text.length - 1)
                    }
                }
                CustomButton {
                    width: 0.133 * wW
                    height: 0.1 * wH
                    text: "AC"
                    onClicked: {
                        inPutFloor.text = ""
                    }
                }
            }

        }
    }
}
