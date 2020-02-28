import QtQuick 2.5
import QtQuick.Controls 2.3

Item {
    id: rootItem
    width: 1200
    height: 620
    property alias etaTextLabel: etaTextLabel
    property alias pv2OnRouteTextLabel: pv2OnRouteTextLabel
    property alias pv1OnRouteTexLabel: pv1OnRouteTexLabel

    Item {
        id: buttonsContainer
        x: rootItem.x
        y: rootItem.y
        width: rootItem.width / 10
        height: rootItem.height

        Text {
            id: pv1OnRouteTexLabel
            x: 21
            y: 143
            width: 68
            height: 26
            text: qsTr("On route: ?")
            font.pixelSize: 12
        }

        Text {
            id: element1
            x: 21
            y: 123
            text: qsTr("PV1")
            font.pixelSize: 12
        }

        Text {
            id: element2
            x: 21
            y: 208
            text: qsTr("PV2")
            font.pixelSize: 12
        }

        Text {
            id: pv2OnRouteTextLabel
            x: 21
            y: 228
            width: 70
            height: 24
            text: qsTr("On route: ?")
            font.pixelSize: 12
        }

        Text {
            id: element4
            x: 21
            y: 295
            width: 21
            height: 22
            text: qsTr("ETA")
            font.pixelSize: 12
        }

        Text {
            id: etaTextLabel
            x: 21
            y: 323
            width: 70
            height: 26
            text: qsTr("0000")
            font.pixelSize: 12
        }
    }

    Item {
        id: mapContainerItem
        objectName: "mapTabMapParent"
        x: buttonsContainer.x + buttonsContainer.width
        y: rootItem.y
        width: rootItem.width - buttonsContainer.width
        height: rootItem.height
    }
}
