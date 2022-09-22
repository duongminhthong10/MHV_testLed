import QtQuick 2.9

CustomButton {
    width: wH * 0.044
    height: wH * 0.044
    contentItem: Image {
        anchors.fill: parent
        source: "image/home_button.png"
    }
    onClicked: {
        mainStackView.pop(null)
    }
}
