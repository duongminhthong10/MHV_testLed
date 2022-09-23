import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: appwindow
    visible: true
    //    visibility: "FullScreen"
    width: 1280
    height: 800
    title: qsTr("Test Led MHV")

    property alias wW: appwindow.width
    property alias wH: appwindow.height
    property string blockName: ""
    property int chonToa
    property int chonNha
    function sentData(txt)
    {
        TCPClient.send(txt)
    }
    /* Main View*/
    StackView {
        id: mainStackView
        anchors.fill: parent
        initialItem: Mainview{}
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
            }
        }
    }
    Loader{
        sourceComponent: {
            /* Run when the app is opening */
        }

    }
}
