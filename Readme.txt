Demo Project for map/routing functionalities provided by QML

Configuration  Tab:
Address Search functionality
Route Calculation functionality.
A routed in computed between stard address(EV Start) and end address (EV End)
Another 2 addressed( points )are selected: PV1 and PV2; The app displays if PV1 and PV2 are situated near the computed route.
Points EV Start, EV End, PV1 and PV2 are selected with a address search function based on a string
The map zoom level changes so all points could be visible on the map
Address search operations and route calculation are fetched online from OpenStreetMap Engine server.

Map Tab:
Calculated route ETA (estimated time of arrival). 
IsAlongRoute for PV1 and PV2

Coding Style
QML files are quite small, therefore more managable.
Route Calculation, Zoom Adjustment, IsAlongRoute and other map operations are found in MapItem.qml file.
Address Search functionality is found in the AddressSearchView.qml file. 
The map object is dynamically shared between Map Tab and Configuration Tab. (map parent is changed, callbacks are automatically adjusted) 

