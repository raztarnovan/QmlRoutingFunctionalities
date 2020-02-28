import QtQuick 2.5
import QtLocation 5.12
import QtPositioning 5.12

VehicleButtonsForm {
    property string searchInputText: ""
    property var selectedLocation
    property var mapItem

    cancelButton.onClicked: {
        mapItem.clearMarkers();
        mapItem.clearRoute();
        mapItem.pv1Location = null;
        mapItem.pv2Location = null;
        mapItem.evStartLocation = null;
        mapItem.evEndLocation = null;
        vehicleButtons.pv1TextField.text = "";
        vehicleButtons.pv2TextField.text = "";
        vehicleButtons.evStartAddressTextField.text = "";
        vehicleButtons.evEndAddressTextField.text = "";
}

    function onRouteText(boolValue)
    {
        if(boolValue)
            return "On route: Yes";
        return "On route: No";
    }

    function getStatusString(status)
    {
        switch (status)
        {
        case RouteModel.Null:
            return "Not Started";
        case RouteModel.Ready:
            return "Computed";
        case RouteModel.Loading:
            return "Loading";
        case RouteModel.Error:
        default:
            return "Error"
        }
    }

    onMapItemChanged:
    {
        if( mapItem !== undefined && mapItem !== null )
        {
            pv1IsOnRouteTextLabel.text = Qt.binding(function() {return onRouteText(mapItem.isPv1AlongRoute)});
            pv2IsOnRouteTextLabel.text = Qt.binding(function() {return onRouteText(mapItem.isPv2AlongRoute)});
            routeStatusText.text = Qt.binding(function(){ return "Route status: " + getStatusString(mapItem.routeModel.status)});
        }
    }

 //Event handlers
    calcRouteButton.onClicked:
    {
        mapItem.calcCoordinateRoute( mapItem.evStartLocation.coordinate.latitude, mapItem.evStartLocation.coordinate.longitude ,
                                    mapItem.evEndLocation.coordinate.latitude, mapItem.evEndLocation.coordinate.longitude );
    }
    onSelectedLocationChanged:
    {

        console.log("selected location changed",selectedLocation);
        // making deep copy of location

        if( selectedLocation !== null && selectedLocation !== undefined)
        {
            var locationCopy = JSON.parse(JSON.stringify(selectedLocation));
            if(vehicleButtons.pv1TextField.focus)
            {
                mapItem.pv1Location = locationCopy;
                mapItem.addMarker("PV1", mapItem.pv1Location.coordinate.latitude, mapItem.pv1Location.coordinate.longitude);
                vehicleButtons.pv1TextField.text = locationCopy.address.text;
            }
            if(vehicleButtons.pv2TextField.focus)
            {
                mapItem.pv2Location = locationCopy;
                mapItem.addMarker("PV2", mapItem.pv2Location.coordinate.latitude, mapItem.pv2Location.coordinate.longitude);
                vehicleButtons.pv2TextField.text = locationCopy.address.text;
            }
            if(vehicleButtons.evStartAddressTextField.focus)
            {
                mapItem.evStartLocation = locationCopy;
                mapItem.addMarker("EV Start", mapItem.evStartLocation.coordinate.latitude, mapItem.evStartLocation.coordinate.longitude );
                vehicleButtons.evStartAddressTextField.text = locationCopy.address.text;
                mapItem.clearRoute();
            }
            if(vehicleButtons.evEndAddressTextField.focus)
            {
                mapItem.evEndLocation = locationCopy;
                mapItem.addMarker("EV End", mapItem.evEndLocation.coordinate.latitude, mapItem.evEndLocation.coordinate.longitude );
                vehicleButtons.evEndAddressTextField.text = locationCopy.address.text;
                mapItem.clearRoute();
            }
        }
    }

    pv1TextField.onActiveFocusChanged:
    {
        if(pv1TextField.focus)
        {
          searchInputText = Qt.binding(function() { return pv1TextField.text });
        }
    }
    pv2TextField.onActiveFocusChanged:
    {
        if(pv2TextField.focus)
        {
          searchInputText = Qt.binding(function() { return pv2TextField.text });
        }
    }
    evStartAddressTextField.onActiveFocusChanged:
    {
        if(evStartAddressTextField.focus)
        {
          searchInputText = Qt.binding(function() { return evStartAddressTextField.text });
        }
    }
    evEndAddressTextField.onActiveFocusChanged:
    {
        if(evEndAddressTextField.focus)
        {
          searchInputText = Qt.binding(function() { return evEndAddressTextField.text });
        }
    }
}
