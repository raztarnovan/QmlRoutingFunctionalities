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
    width: 1280
    height: 720
    title: qsTr("Route Calculation Demo")

    property MapItem mapItem: MapItem{}

    Timer {
        id: tabInitTimer
        interval: 100; running: true; repeat: false
        onTriggered: tabViewRoot.currentIndex = 1;
    }
    Component.onCompleted:
    {
        tabInitTimer.start();
    }

    TabView {
        id: tabViewRoot
        anchors.fill: parent

        onCurrentIndexChanged:
        {
            if (currentIndex == 0)
            {
                setMapByObjectName(tabViewRoot, "mapTabRoot");
                setMapParentByObjectName( tabViewRoot, "mapTabMapParent" );
            }
            else if( currentIndex == 1)
            {
                setMapByObjectName(tabViewRoot, "configTabRoot")
                setMapParentByObjectName( tabViewRoot, "configTabMapParent" );
            }
        }

        Tab {
            title: "Map"
            MapTabB{}
        }
        Tab {
            title: "Configuration"
            ConfigTab{}
        }
        Tab {
            title: "MQTT"
            Rectangle { color: "green" }
        }
    }

    function setMapParentByObjectName(rootObject, inputObjectName )
    {
        if( rootObject !== undefined && rootObject !== null )
        {
        for(var i = 0; i < rootObject.children.length; ++i)
            if( rootObject.children[i].objectName===inputObjectName ){
                mapItem.parent = rootObject.children[i];
                mapItem.width =  rootObject.children[i].width;
                mapItem.height = rootObject.children[i].height;
                mapItem.x = rootObject.children[i].x;
                mapItem.y = rootObject.children[i].y;
            }
            else
            {
                setMapParentByObjectName(rootObject.children[i], inputObjectName );
            }
        }
    }

    function setMapByObjectName(rootObject, inputObjectName )
    {
        if( rootObject !== undefined && rootObject !== null )
        {
        for(var i = 0; i < rootObject.children.length; ++i)
            if( rootObject.children[i].objectName===inputObjectName ){
                rootObject.children[i].mapItem = mapItem;
            }
            else
            {
                setMapByObjectName(rootObject.children[i], inputObjectName );
            }
        }
    }
}
