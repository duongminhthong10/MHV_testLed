import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    /*Menu*/
    id: menu
    anchors.fill: parent
    /*Anh nen*/
    Image {
        anchors.fill: parent
        source: "image/bg_main.png"
    }

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
    /*Icon exit*/
    Image {
        id: exitBtn
        width: wH * 0.044
        height: wH * 0.044
        source: "image/back_button.png"
        anchors { bottom: parent.bottom; bottomMargin: wH * 0.02; right: parent.right; rightMargin: wW * 0.02 }
        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                appwindow.close()
            }
        }
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
            spacing: 5
            add: Transition {
                NumberAnimation {properties: "opacity"; duration: 500; from: 0; to : 1} // hieu ung khi click
            }
            CustomButton {
                id: onlyLed
                width: wW * 0.19
                height: wH * 0.06
                checkable: true
                text: "ON/OFF từng Led"
                onClicked: {
                    manyLed.checked = false
                    randomLed.checked = false
                    fullLed.checked = false
                }
            }
            Row {
                id: onlyLedOption
                visible: (onlyLed.checked) ? true : false
                spacing: 5
                anchors.horizontalCenter:onlyLed.horizontalCenter
                TextInputCustom {
                    id: textInput_ledOnly
                    width: wW * 0.06
                    height: wH * 0.04
                }
                CustomButton {
                    height: wH * 0.04
                    width: wW * 0.04
                    text: "ON"
                    property string insertTxt: ""
                    property string inputTxt: textInput_ledOnly.text
                    property string test: inputTxt.charAt(0)
                    onClicked:
                    {
                        console.log(inputTxt)
                        switch (test)
                        {
                        case "T":
                            console.log("sang " +  inputTxt.substring(1))
                            break
                        default:
                            console.log("Default")
                            for (var i = 0; i < inputTxt; i++)
                            {
                                insertTxt = insertTxt + "0"
                            }
                            sentData("DKTC0" + insertTxt + "1");
                            insertTxt = ""
                        }
                    }
                }
                CustomButton {
                    height: wH * 0.04
                    width: wW * 0.04
                    text: "OFF"
                    property string insertTxt: ""
                    property string inputTxt: textInput_ledOnly.text
                    property string test: inputTxt.charAt(0)
                    onClicked:
                    {
                        console.log(inputTxt)
                        switch (test)
                        {
                        case "T":
                            console.log("tat " +  inputTxt.substring(1))
                            break
                        default:
                            console.log("Default")
                            for (var i = 0; i < inputTxt; i++)
                            {
                                insertTxt = insertTxt + "0"
                            }
                            sentData("DKTC0" + insertTxt + "0");
                            insertTxt = ""
                        }
                    }
                }
            }
        }
        Column {
            spacing: 6
            add: Transition {
                NumberAnimation {properties: "opacity"; duration: 500; from: 0; to : 1} // hieu ung khi click
            }
            CustomButton {
                id: manyLed
                width: wW * 0.19
                height: wH * 0.06
                checkable: true
                text: "ON/OFF nhiều Led"
                onClicked: {
                    onlyLed.checked = false
                    randomLed.checked = false
                    fullLed.checked = false
                }
            }
            Row {
                visible: (manyLed.checked) ? true : false
                anchors.horizontalCenter:manyLed.horizontalCenter
                spacing: 9
                TextInputCustom {
                    id: inputLedFrom
                    width: wW * 0.06
                    height: wH * 0.04
                }
                Text {
                    id: name
                    text: qsTr("đến")
                    color: "#ffc000"
                    font.pixelSize: inputLedTo.height / 2
                    anchors.verticalCenter: inputLedFrom.verticalCenter
                }
                TextInputCustom {
                    id: inputLedTo
                    width: wW * 0.06
                    height: wH * 0.04
                }
            }
            Row {
                visible: (manyLed.checked) ? true : false
                anchors.horizontalCenter:manyLed.horizontalCenter
                spacing: 10
                CustomButton {
                    height: wH * 0.04
                    width: wW * 0.04
                    text: "ON"
                }
                CustomButton {
                    height: wH * 0.04
                    width: wW * 0.04
                    text: "OFF"
                }
            }

        }
        Column {
            spacing: 6
            CustomButton {
                id: randomLed
                width: wW * 0.19
                height: wH * 0.06
                checkable: true
                text: "ON/OFF Random"
                onClicked: {
                    onlyLed.checked = false
                    manyLed.checked = false
                    fullLed.checked = false
                    if(randomLed.checked) // neu ON thi gui
                    {
                        //TCPClient.connectToServer()
                        sentData("HU01")

                    }
                    else // neu off thi gui
                    {
                        sentData("AAA0")
                    }
                }
            }
        }
        Column {
            spacing: 6
            CustomButton {
                id: fullLed
                width: wW * 0.19
                height: wH * 0.05
                checkable: true
                text: "ON/OFF FULL"
                onClicked: {
                    onlyLed.checked = false
                    randomLed.checked = false
                    manyLed.checked = false
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
        }
    }

}
