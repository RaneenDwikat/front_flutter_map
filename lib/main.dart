import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class myHomePage extends StatefulWidget {
  var lati;
  var long;
  myHomePage({Key? key}) : super(key: key);

  @override
  _myHomePageState createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  List<Marker> marker = [];
  final MapController _mapctl = MapController();
  var lati;
  var long;
  var street = '';
  var city = '';
  setMarker() {
    return marker;
  }

  addMarker() {
    marker.add(Marker(
        point: LatLng(point.latitude, point.longitude),
        height: 45.0,
        width: 45.0,
        builder: (context) => Container(
              child: IconButton(
                icon: const Icon(Icons.location_on),
                color: Colors.red,
                iconSize: 46.0,
                onPressed: () {},
              ),
            )));
    return marker;
  }

  Future getAddress() async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(point.latitude, point.longitude);
    print(placeMark);
    setState(() {
      city = placeMark.first.locality.toString();
      street = placeMark.first.street.toString();
    });
  }

  Future getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    point.longitude = position.longitude;
    point.latitude = position.latitude;
    print('current location is $position');
  }

  var point = LatLng(32.04198170956528, 35.214836562281235);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "My Location",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white),
            ),
            backgroundColor: Color(0xffE63220),
            centerTitle: true),
        body: FlutterMap(
            mapController: _mapctl,
            options: MapOptions(
                minZoom: 4.0,
                onMapCreated: (p) async {
                  // MarkerLayerOptions(markers:await setMarker());
                },
                center: point),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: setMarker())
            ]),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            //show my location
            backgroundColor: Color(0xffE63220),
            onPressed: () async {
              await getCurrentLocation();
              print('before $point');
              var latlng = LatLng(point.latitude, point.longitude);
              double zoom = 10.0;
              _mapctl.move(latlng, zoom);
              await getAddress();
              await addMarker();
              //MarkerLayerOptions(markers:setMarker());
              print('after $point');
            },
            heroTag: null,
            child: const Icon(
              Icons.location_searching,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            //save my location to database
            backgroundColor: Color(0xffE63220),
            onPressed: () => () {},
            heroTag: null,
            child: const Icon(Icons.save),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            //back to home
            backgroundColor: Color(0xffE63220),
            onPressed: () => () {
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splash()));
            },
            heroTag: null,
            child: const Icon(Icons.arrow_back),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child:
                  //TextField(decoration: InputDecoration(border: InputBorder.none, hintText: "${city}",),
                  //  Text(city+" , "+street),

                  Text(city),
            ),
          ),
        ]));
  }
}
