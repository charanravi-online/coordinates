import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatefulWidget {
  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  String _latitude = 'Unknown';
  String _longitude = 'Unknown';

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  void requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _getLocation();
    } else if (status.isDenied) {
      // Location permission denied
    } else if (status.isPermanentlyDenied) {
      // Location permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }

  void _getLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _latitude = '${position.latitude}';
      _longitude = '${position.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Location App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
              'Your coordinates are:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
              Text(
                'Latitude: $_latitude',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Longitude: $_longitude',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
