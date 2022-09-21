import QtQuick 2.0

CustomButton {
    width: wH * 0.044
    height: wH * 0.044
    contentItem: Image {
        anchors.fill: parent
        source: "image/back_button.png"
    }
    onClicked: appwindow.close()
}
