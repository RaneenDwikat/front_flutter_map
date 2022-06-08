import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'main.dart';




class Splash extends StatefulWidget {


  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState(){
  super.initState();
  _navegatetohome();
  }
  _navegatetohome() async{
  await Future.delayed( const Duration(milliseconds: 1500),(){});
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> myHomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Location",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.white),
          ),
          backgroundColor: Colors.amber,
          centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.location_on,color: Colors.red,size: 56.0,),
          ],
        ),
      ),
    );
  }
}