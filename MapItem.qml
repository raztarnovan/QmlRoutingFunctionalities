import QtQuick 2.5
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Dialogs 1.2

Item
{
    id: rootItem

    property alias map: map
    property alias routeModel: routeModel
    property alias routeQuery: routeQuery

    property var pv1Location
    property var pv2Location
    property var evStartLocation
    property var evEndLocation

    property bool isPv1AlongRoute: false
    property bool isPv2AlongRoute: false

    property var markerList: []

    function distToZoomLevel(distance, latitudeDeg)
    {
        var currentPixelSurface = distance / width;

        var earthCircum = 40075016.686; // meters
        var zoomLevel;
        var pixSurface = 0;
        for(zoomLevel = 20;  zoomLevel> 0; zoomLevel-- )
        {
            pixSurface = earthCircum * Math.cos(latitudeDeg * Math.PI / 180) / Math.pow(2, zoomLevel+8);
            if (pixSurface > currentPixelSurface)
            {
                return zoomLevel;
            }
        }
        return zoomLevel;
    }

	// compute if a position in near the route
    function isAlongRoute( coord )
	{
		if (routeModel.count > 0)
		{
			var routePoints = routeModel.get(0).path;
			var i;
            var routePoint = QtPositioning.coordinate(0, 0);
            var currentCoord = QtPositioning.coordinate(0, 0);
			for(i = 0; i < routePoints.length; i++)
			{
                routePoint = QtPositioning.coordinate(routePoints[i].latitude, routePoints[i].longitude);
                currentCoord = QtPositioning.coordinate(coord.latitude, coord.longitude);
                //coordinates must be initialized with QtPositioning, otherwhise distanceTo may not work properly
                if (currentCoord.distanceTo(routePoint) < 200)
				{
					//distance smaller than 200 m
					return true;
				}
			}
		}
		return false;
	}

    // Add Marker function check marker.qml
    function addMarker(name, latitude, longitude)
    {
        var i;
        for(i = 0; i < markerList.length; i++)
        {
            if( markerList[i].labelText === name)
            {
                map.removeMapItem(markerList[i]);
                markerList.splice(i,1);
                break;
            }
        }
        var component = Qt.createComponent("qrc:///qml/Marker.qml");
        var item = component.createObject(rootItem, { coordinate:
        QtPositioning.coordinate(latitude, longitude), labelText: name });
        markerList.push(item);
        map.addMapItem(item);

        var j;
        var maxDist = 0;
        var avgLat = 0;
        var avgLong = 0;
        for(i = 0; i < markerList.length; i++)
        {
            avgLat += markerList[i].coordinate.latitude;
            avgLong += markerList[i].coordinate.longitude;
            for(j = 0; j < markerList.length; j++)
            {
                var firstPoint =  QtPositioning.coordinate(markerList[i].coordinate.latitude, markerList[i].coordinate.longitude);
                var secondPoint =  QtPositioning.coordinate(markerList[j].coordinate.latitude, markerList[j].coordinate.longitude);
                var currentDist = firstPoint.distanceTo(secondPoint);
                if(currentDist > maxDist)
                {
                    maxDist = currentDist;
                }
            }
        }
        avgLat = avgLat / markerList.length;
        avgLong = avgLong / markerList.length;
        var zoomLevel = 14;
        if(markerList.length > 1 && maxDist > 200 )
            zoomLevel = distToZoomLevel(maxDist, avgLat);

        map.zoomLevel = zoomLevel;

        map.center = QtPositioning.coordinate(avgLat, avgLong);

    }

    function clearMarkers()
    {
        map.clearMapItems();
    }

    function clearRoute()
    {
        routeModel.reset();
        routeQuery.clearWaypoints();
        routeModel.update();
    }

    function calcCoordinateRoute(from1, from2, to1, to2)
    {
        var from = QtPositioning.coordinate(from1, from2)
        var to = QtPositioning.coordinate(to1, to2)
        map.calculateCoordinateRoute(from, to);
    }

    Map
    {
        id: map
        anchors.fill: parent
        plugin: Plugin
        {
            id: mapPlugin
            name: "osm"
        }
        center: QtPositioning.coordinate(45.0696891,7.6878744)
        zoomLevel: 14

        property alias routeQuery: routeQuery
        property alias routeModel: routeModel

        function calculateCoordinateRoute(startCoordinate, endCoordinate)
        {
            // clear away any old data in the query
            routeModel.reset();
            routeQuery.clearWaypoints();
            // add the start and end coords as waypoints on the route
            routeQuery.addWaypoint(startCoordinate)
            routeQuery.addWaypoint(endCoordinate)
            routeQuery.travelModes = RouteQuery.CarTravel
            routeQuery.routeOptimizations = RouteQuery.FastestRoute
            routeModel.update();
        }

        //! [routemodel0]
        RouteModel {
            id: routeModel
            plugin : map.plugin
            query:  RouteQuery {
                id: routeQuery
            }
            onStatusChanged: {
                if (status === RouteModel.Null )
                {
                    console.log("on_StatusChanged_RouteModel: status is NULL");
                }

                if (status === RouteModel.Ready) {
                    console.log("on_StatusChanged_RouteModel: status is READY");

                    switch (count) {
                    case 0:
                        // technically not an error
                        map.routeError()
                        console.log("on_StatusChanged_RouteModel: count is 0");
                        break
                    default:
                        //     map.showRouteList()
                        console.log("on_StatusChanged_RouteModel: count is " + count);
                        break
                    }

                } else if(status == RouteModel.Loading) {
                    console.log("on_StatusChanged_RouteModel: status is LOADING");
                } else if (status == RouteModel.Error) {
                        console.log( "on_StatusChanged_RouteModel: status is ERROR, with code", routeModel.error, "and error string", routeModel.errorString );
                }
            }
        }
        //! [routemodel0]


        //! [routedelegate0]
        Component {
            id: routeDelegate

            MapRoute {
                id: route
                route: routeData
                line.color: "#46a2da"
                line.width: 5
                smooth: true
                opacity: 0.8
         //! [routedelegate0]
        //! [routedelegate1]
            }
        }

        //! [routeview0]
        MapItemView {
            model: routeModel
            delegate: routeDelegate
        //! [routeview0]
            autoFitViewport: true
        //! [routeview1]
        }
        //! [routeview1]

    }

    Connections
    {
        target: routeModel
        onStatusChanged:
        {
            // route computed succesfully
            if( routeModel.status === RouteModel.Ready)
            {
                isPv1AlongRoute = Qt.binding( function(){ return isAlongRoute(pv1Location.coordinate)});
                isPv2AlongRoute = Qt.binding( function(){ return isAlongRoute(pv2Location.coordinate)});
            }
        }
    }


}
