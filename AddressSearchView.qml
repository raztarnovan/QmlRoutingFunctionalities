import CustomLib 1.0
import QtQuick 2.5
import QtLocation 5.12
import QtPositioning 5.12

Item
{
    id: root
    property alias inputText: iAddressList.inputText
    property var selectedLocation

	Text
	{
		id: iTextAddressList
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		height: parent.height / 10
		text: "Address Search"
	}

    ListView {
        id: listView
        anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.top: iTextAddressList.bottom
		anchors.bottom: parent.bottom
        spacing: 2

        model: geocodeModel
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        delegate: fruitDelegate
    }
    GeocodeModel {
        id: geocodeModel
        objectName: "geocodeModel"
        plugin: Plugin{ name: "osm" }
        autoUpdate: true
        query: iAddressList.inputText;
    }
    AddressList
    {
        id: iAddressList
        objectName: "addressList"
    }

    Component {
        id: fruitDelegate
        Item {
            width: parent.width
            height: fullAddressText.contentHeight * 2
            Text
            {
                anchors.fill: parent
                id: fullAddressText
                text: index >= 0 ? geocodeModel.get(index).address.text : ""
                fontSizeMode: Text.HorizontalFit
                elide: Text.ElideRight
            }

            MouseArea
            {
                z: 1
                anchors.fill: parent
                onClicked:
                {
					if(index >= 0)
					{     
						listView.currentIndex = index;
                        iAddressList.selectedLocation = geocodeModel.get(index).location;
                        root.selectedLocation = geocodeModel.get(index);
					}
                }
            }
        }
    }
}
