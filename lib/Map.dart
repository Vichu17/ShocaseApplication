import 'dart:async';
import 'dart:math';
import 'package:eshop/Add_Address.dart';
import 'package:eshop/Helper/Constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Helper/Session.dart';
import 'Helper/String.dart';
import 'Profile.dart';

class Map extends StatefulWidget {
  final double latitude, longitude;
  final String from;

  const Map({Key key, this.latitude, this.longitude, this.from})
      : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng latlong = null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller;
  TextEditingController locationController = TextEditingController();

  // String latitude, longitude;

  Set<Marker> _markers = Set();

  //LatLng _mainLocation;

  Future getCurrentLocation() async {
    List placemark = await Geolocator()
        .placemarkFromCoordinates(widget.latitude, widget.longitude);

    print("lat**${widget.latitude}***${widget.longitude}");
    setState(() {
      latlong = new LatLng(widget.latitude, widget.longitude);
      // latitude = widget.latitude.toString();
      // longitude = widget.longitude.toString();
      //_mainLocation = latlong;
      print(widget.latitude);
      print(widget.longitude);
      _cameraPosition = CameraPosition(target: latlong, zoom: 15.0, bearing: 0);
      if (_controller != null)
        _controller
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      var address;
      address = placemark[0].name;
      address = address + "," + placemark[0].subLocality;
      address = address + "," + placemark[0].locality;
      address = address + "," + placemark[0].country;
      address = address + "," + placemark[0].postalCode;
      locationController.text = address;
      _markers.add(Marker(
        markerId: MarkerId("Marker"),
        position: LatLng(widget.latitude, widget.longitude),
      ));
    });
  }

  @override
  void initState() {
    super.initState();

    _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(CHOOSE_LOCATION, context),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                (latlong != null)
                    ? GoogleMap(
                        initialCameraPosition: _cameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller = (controller);
                          _controller.animateCamera(
                              CameraUpdate.newCameraPosition(_cameraPosition));
                        },
                        markers: this.myMarker(),
                        onTap: (latLng) {
                          setState(() {
                            latlong = latLng;
                          });
                        })
                    : Container(),

              ]),
            ),
            TextField(
              cursorColor: Colors.black,
              controller: locationController,
              readOnly: true,
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 0),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                ),
                hintText: "pick up",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 12.0),
              ),
            ),
            RaisedButton(
              child: Text("Update Location"),
              onPressed: () {
                print("updated***$latlong");

                if(widget.from==ADDADDRESS)
                  {
                    latitude=latlong.latitude.toString();
                    longitude=latlong.longitude.toString();
                  }else if(widget.from==PROFILE){
                  lat=latlong.latitude.toString();
                  long=latlong.longitude.toString();
                }
              },
            ),
          ],
        )));
  }

  Set<Marker> myMarker() {
    if (_markers != null) {
      _markers.clear();
    }

    _markers.add(Marker(
      markerId: MarkerId(Random().nextInt(10000).toString()),
      position: LatLng(latlong.latitude, latlong.longitude),
    ));

    getLocation();

    return _markers;
  }

  Future<void> getLocation() async {
    List placemark = await Geolocator()
        .placemarkFromCoordinates(latlong.latitude, latlong.longitude);
    var address;
    address = placemark[0].name;
    address = address + "," + placemark[0].subLocality;
    address = address + "," + placemark[0].locality;
    address = address + "," + placemark[0].country;
    address = address + "," + placemark[0].postalCode;
    locationController.text = address;
    setState(() {});
  }
}