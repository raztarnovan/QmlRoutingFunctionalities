import QtQuick 2.5
import QtPositioning 5.12
import QtLocation 5.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


Rectangle {
   anchors.fill: parent
   color: "lemonchiffon"
   //opacity: 0.05
    Row
    {
        id: configRoot
        anchors.fill: parent
        spacing: 2
        objectName: "configTabRoot"

        property var mapItem

        Item
        {
            id: configTabMapContainerItem
            objectName: "configTabMapParent"
            height: parent.height
            width: parent.width / 3
        }
        Item {
            height: parent.height
            width: parent.width / 3
            AddressSearchView
            {
                id: addressSearchView
                anchors.fill: parent
                inputText: vehicleButtons.searchInputText
            }
        }

        Item
        {
            height: parent.height
            width: parent.width / 3
            VehicleButtons
            {
                id: vehicleButtons
                objectName: "vehicleButtons"
                mapItem: configRoot.mapItem
                anchors.fill: parent
                selectedLocation: addressSearchView.selectedLocation
            }
        }
    }
}

