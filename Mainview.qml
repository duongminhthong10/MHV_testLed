import QtQuick 2.9
import QtQuick.Controls 2.15

Item {
    /*Menu*/
    id: menu
    /*Anh nen*/
    Image {
        anchors.fill: parent
        source: "image/bg_main.png"
    }
    focus: true
    Image {
        anchors {fill: parent; rightMargin: wW * 0.22}
        source: "image/bg_pig.jpg"
    }
    /*Thoi gian xuat hien icon*/
    Timer
    {
        interval: 1000
        running: true
        onTriggered: {
            t302Icon.opacity = 1
            fulloption.opacity = 1
        }
    }
    /*Icon302*/
    Image {
        id: t302Icon
        opacity: 0
        width: wW * 0.18
        height: wH * 0.13
        source: "image/logo.png"
        x: wW * 0.8
        y: wH * 0.035
        Behavior on opacity {
            NumberAnimation {duration: 1000}
        }
    }
    /*Icon back and home*/
    BackButton {
        id: btnBack
        onClicked:
        {
            appwindow.close()
        }

        anchors { bottom: parent.bottom; bottomMargin: wH * 0.02; right: parent.right; rightMargin: wW * 0.02 }
    }
    HomeButton {
        anchors {bottom: parent.bottom; bottomMargin: wH * 0.02; right: btnBack.left; rightMargin: wW * 0.01}
    }

    /*Khoi cac option*/
    Column {
        id : fulloption
        opacity: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: wW * 0.015
        spacing: 30
        Behavior on opacity {
            NumberAnimation {duration: 500}
        }
        Column {
            add: Transition {
                NumberAnimation { properties: "opacity"; duration: 500; from: 0; to: 1 }
            }
            spacing: 6
            CustomButton {
                id: controlBlockOnly
                width: wW * 0.2
                height: wH * 0.06
                checkable: true
                text: "Điều khiển từng khối"
                onClicked:
                {
                    animationLed.checked = false
                }
            }
            Grid {
                columns: 2
                spacing: 4
                flow: Grid.LeftToRight
                anchors.horizontalCenter: parent.horizontalCenter
                visible: controlBlockOnly.checked ? true : false
                Repeater {
                    model: 10
                    CustomButton {
                        id: indexBlock
                        width: wW * 0.056
                        height: wH * 0.034
                        text: "HH" + parseInt(index + 1)
                        onClicked: {
                            blockName = indexBlock.text
                            mainStackView.push("BlockView.qml")
                            chonToa = parseInt(index + 1)
                        }
                    }
                }
            }
        }
        Column {
            add: Transition {
                NumberAnimation { properties: "opacity"; duration: 500; from: 0; to: 1 }
            }
            spacing: 6
            CustomButton {
                id: animationLed
                width: wW * 0.2
                height: wH * 0.06
                checkable: true
                text: "Các hiệu ứng Led"
                onClicked: {
                    controlBlockOnly.checked = false
                }
            }
            Column {
                id: animationOption
                spacing: 12
                anchors.horizontalCenter: parent.horizontalCenter
                visible: animationLed.checked ? true :false
                CustomButton {
                    id: fullLed
                    width: wW * 0.12
                    height: wH * 0.034
                    text: checked ? "TẮT TOÀN BỘ" : "BẬT TOÀN BỘ"
                    checkable: true
                    font.bold: false
                    onClicked:
                    {
                        if(fullLed.checked) // neu ON thi gui
                        {
                            sentData("AAA1")
                        }
                        else // neu off thi gui
                        {
                            sentData("AAA0")
                        }
                    }
                }
                CustomButton {
                    width: wW * 0.12
                    height: wH * 0.034
                    text: "SÁNG TỪNG TẦNG"
                    font.bold: false
                }
                CustomButton {
                    id: randomLed
                    width: wW * 0.12
                    height: wH * 0.034
                    text: "SÁNG NGẪU NHIÊN"
                    font.bold: false
                    onClicked:
                    {
                        sentData("HU01")
                    }
                }
            }
        }
    }
}
