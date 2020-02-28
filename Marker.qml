import QtQuick 2.5
import QtLocation 5.12
import QtQuick.Controls 2.3


MapQuickItem
{
    id: marker
    anchorPoint.x: marker.width / 4
    anchorPoint.y: marker.height
    property string labelText
    sourceItem: Image
    {
        Image
        {
            id: icon
            source: "qrc:///images/pin.png"
            sourceSize.width: 25
            sourceSize.height: 25
        }
        Rectangle
        {
            id: tag
            anchors.centerIn: label
            width: label.width + 4
            height: label.height + 2
            color: "black"
        }
        Label
        {
            id: label
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 20
            anchors.verticalCenterOffset: -12
            font.pixelSize: 16
            text: labelText
            color: "white"
        }
    }
}
