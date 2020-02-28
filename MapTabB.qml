import QtQuick 2.5
import QtPositioning 5.12
import QtLocation 5.12

MapTabBForm {
    property var mapItem
    objectName: "mapTabRoot"

    function onRouteText(boolValue)
    {
        if(boolValue)
            return "On route: Yes";
        return "On route: No";
    }

    function convertSecondToDisplayFormat(seconds)
    {
        var measuredTime = new Date(null);
        measuredTime.setSeconds(seconds); // specify value of SECONDS
        var MHSTime = measuredTime.toISOString().substr(11, 8);
        return MHSTime;
    }

    onMapItemChanged:
    {
        if( mapItem !== undefined && mapItem !== null )
        {
            pv1OnRouteTexLabel.text = Qt.binding(function() {return onRouteText(mapItem.isPv1AlongRoute)});
            pv2OnRouteTextLabel.text = Qt.binding(function() {return onRouteText(mapItem.isPv2AlongRoute)});

            if( mapItem.routeModel !== undefined && mapItem.routeModel !== null && mapItem.routeModel.count > 0 )
            {
                etaTextLabel.text = Qt.binding(function() {return convertSecondToDisplayFormat(mapItem.routeModel.get(0).travelTime) });
            }
        }
    }
    Connections
    {
        target: mapItem !== undefined && mapItem.routeModel !== undefined ? mapItem.routeModel :  null
        onStatusChanged:
        {
            if( mapItem.routeModel.status === mapItem.RouteModel.Ready)
            {
                etaTextLabel.text = Qt.binding(function() {return convertSecondToDisplayFormat(mapItem.routeModel.get(0).travelTime) });
            }
        }
    }
}
