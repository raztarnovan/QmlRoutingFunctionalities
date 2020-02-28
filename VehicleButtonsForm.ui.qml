import QtQuick 2.5
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Item {
    property alias pv1TextField: pv1TextField
    property alias pv2TextField: pv2TextField
    property alias evStartAddressTextField: evStartAddressTextField
    property alias calcRouteButton: calcRouteButton
    property alias evEndAddressTextField: evEndAddressTextField
    property alias pv1IsOnRouteTextLabel: pv1IsOnRouteTextLabel
    property alias pv2IsOnRouteTextLabel: pv2IsOnRouteTextLabel
    property alias cancelButton: cancelButton
    property alias routeStatusText: routeStatusText
    Button {
        id: calcRouteButton
        x: parent.x + parent.width / 2 - width / 2
        y: parent.y + parent.height - height * 3
        text: qsTr("Calculate Route")
    }

    Button {
        id: cancelButton
        x: parent.x + parent.width / 2 - width / 2
        y: parent.y + parent.height - height * 3 / 2
        text: qsTr("Reset Route Data")
    }

    TextField {
        id: pv1TextField
        x: parent.x + parent.width / 2 - width / 2
        y: parent.y + pv1TextLabel.height * 2
        text: "Bologna"
    }

    TextField {
        id: pv2TextField
        x: parent.x + parent.width / 2 - width / 2
        y: pv1TextField.y + pv1TextField.height * 2
        text: "Firenze"
    }

    TextField {
        id: evStartAddressTextField
        x: parent.x + parent.width / 2 - width / 2
        y: parent.y + parent.height * 0.4
        text: "Bologna"
    }

    Text {
        id: pv1TextLabel
        x: pv1TextField.x
        y: pv1TextField.y - height
        text: qsTr("Private Vehicle 1")
        font.pixelSize: 12
    }

    Text {
        id: pv2textLabel
        x: pv1TextField.x
        y: pv2TextField.y - height
        width: 89
        height: 20
        text: qsTr("Private Vehicle 2")
        font.pixelSize: 12
    }

    Text {
        id: evTextLabel
        x: evStartAddressTextField.x
        y: evStartAddressTextField.y - height
        text: qsTr("Emergency Vehicle")
        font.pixelSize: 12
    }

    Text {
        id: element
        x: evStartAddressTextField.x - evStartAddressTextField.width / 2
        y: 41
        text: qsTr("Location")
        font.pixelSize: 12
    }

    Text {
        id: element1
        x: evStartAddressTextField.x - evStartAddressTextField.width / 2
        y: 118
        text: qsTr("Location")
        font.pixelSize: 12
    }

    Text {
        id: element2
        x: evStartAddressTextField.x - evStartAddressTextField.width / 2
        y: evStartAddressTextField.y + evStartAddressTextField.height - height
        width: evStartAddressTextField.x - evStartAddressTextField.width / 2
        height: 15
        text: qsTr("Start Location")
        font.pixelSize: 12
    }

    TextField {
        id: evEndAddressTextField
        x: parent.x + parent.width / 2 - width / 2
        y: evStartAddressTextField.y + evStartAddressTextField.height * 3 / 2
        text: "Firenze"
    }

    Text {
        id: element3
        x: evStartAddressTextField.x - evStartAddressTextField.width / 2
        y: evEndAddressTextField.y + evEndAddressTextField.height - height
        text: qsTr("End Location")
        font.pixelSize: 12
    }

    Text {
        id: pv1IsOnRouteTextLabel
        x: pv1TextField.x + pv1TextField.width - width
        y: pv1TextField.y - height
        text: qsTr("Is on route: ?")
        font.pixelSize: 12
    }

    Text {
        id: pv2IsOnRouteTextLabel
        x: pv2TextField.x + pv2TextField.width - width
        y: pv2TextField.y - height
        text: qsTr("Is on route: ?")
        font.pixelSize: 12
    }

    Text {
        id: routeStatusText
        x: calcRouteButton.x
        y: calcRouteButton.y - height * 2
        width: evEndAddressTextField.width
        height: 14
        text: qsTr("Route status: ?")
        font.pixelSize: 12
    }
}




/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
