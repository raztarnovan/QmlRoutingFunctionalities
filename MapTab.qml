import QtQuick 2.5
import QtQuick.Controls 2.3

Item
{
    anchors.fill: parent

    objectName: "mapTabRoot"

    property var mapItem;
    Item
    {
        id: buttonsItem
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width / 10
        Text
        {
            id: etaText
            anchors.top: parent.top
            anchors.left: parent.left
            text: "Eta"
        }
        Text
        {
            id: nameText
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: qsTr("text")
        }
    }
    Item
    {
        objectName: "mapTabMapParent"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        anchors.left: buttonsItem.right
    }
}
