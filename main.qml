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
    width: 1080
    height: 720
    title: qsTr("Hello World")
//    MapItem{
//        id: iMapItem
//        anchors.fill: parent
//    }

    property var mapParent

    Timer {
        id: tabInitTimer
        interval: 200; running: true; repeat: false
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
                setParentByObjectName( tabViewRoot, "mapTabMapParent" );
            }
            else if( currentIndex == 1)
            {
                setMapByObjectName(tabViewRoot, "configTabRoot")
                setParentByObjectName( tabViewRoot, "configTabMapParent" );
            }
        }

        Tab {
            title: "Red"
            MapTabB{}
        }
        Tab {
            title: "Blue"
            ConfigTab{}
        }
        Tab {
            title: "MQTT"
            Rectangle { color: "green" }
        }
        MapItem
        {
            id: iMapItem
            //anchors.fill: parent
        }
    }

    function setParentByObjectName(rootObject, inputObjectName )
    {
        if( rootObject !== undefined && rootObject !== null )
        {
        for(var i = 0; i < rootObject.children.length; ++i)
            if( rootObject.children[i].objectName===inputObjectName ){
                iMapItem.parent = rootObject.children[i];
                iMapItem.width =  rootObject.children[i].width;
                iMapItem.height = rootObject.children[i].height;
                iMapItem.x = rootObject.children[i].x;
                iMapItem.y = rootObject.children[i].y;
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
                setMapByObjectName(rootObject.children[i], inputObjectName );
            }
        }
    }
}
