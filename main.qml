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
    function sentData(txt)
    {

        TCPClient.send(txt)
    }

    /* Main View*/
    StackView {
        id: mainStackView
        anchors.fill: parent
        initialItem: Mainview{}
    }


}
