import QtQuick 2.5
import QtPositioning 5.12
import QtLocation 5.12
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick 2.12
import QtQuick.Window 2.12


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
//    MapItem{
//        id: iMapItem
//        anchors.fill: parent
//    }

    property var mapParent

    TabView {
        id: tabViewRoot
        anchors.fill: parent
        Component.onCompleted:
        {
            tabViewRoot.currentIndex = 2;
        }

        onCurrentIndexChanged:
        {
            console.log("Current index changed");
            if (currentIndex == 0)
            {
                setMapByObjectName(tabViewRoot, "mapTabRoot");
                setParentByObjectName( tabViewRoot, "mapTabMapParent" );
                iMapItem.state = "mapTabParent";
            }
            else if( currentIndex == 1)
            {
                setMapByObjectName(tabViewRoot, "configTabRoot")
                setParentByObjectName( tabViewRoot, "configTabMapParent" );
                iMapItem.state = "configTabParent";
            }
        }

        Tab {
            title: "Red"
            z:1
            MapTabB
            {
                id: iMapTab
                z:1
            }
        }
        Tab {
            title: "Blue"
            z:1
            ConfigTab
            {
                id: iConfigTab
                z:1
              //  configRoot.mapItem: iMapId
            }
        }
        Tab {
            z:1
            title: "MQTT"
            Rectangle { color: "green" }
        }
        MapItem
        {
            id: iMapItem
            //anchors.fill: parent
            states:
                [
                State {
                name: "configTabParent"
                ParentChange { target: iMapItem; parent: mapParent; width: mapParent.width; height: mapParent.height }
                    },
                State {
                    name: "mapTabParent"
                    ParentChange { target: iMapItem; parent: mapParent; width: mapParent.width; height: mapParent.height}
                    }
                ]
        }
    }

    function setParentByObjectName(rootObject, inputObjectName )
    {
        if( rootObject !== undefined && rootObject !== null )
        {
        for(var i = 0; i < rootObject.children.length; ++i)
            if( rootObject.children[i].objectName===inputObjectName ){
                mapParent = rootObject.children[i];
            }
            else
            {
                setParentByObjectName(rootObject.children[i], inputObjectName );
            }
        }
    }

    function setMapByObjectName(rootObject, inputObjectName )
    {
        if( rootObject !== undefined && rootObject !== null )
        {
        for(var i = 0; i < rootObject.children.length; ++i)
            if( rootObject.children[i].objectName===inputObjectName ){
                rootObject.children[i].mapItem = iMapItem;
            }
            else
            {
                setParentByObjectName(rootObject.children[i], inputObjectName );
            }
        }
    }
}
