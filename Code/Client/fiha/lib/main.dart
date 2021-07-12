import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiha',
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _mapStyle;
  GoogleMapController? mapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //Init
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/mapstyle/mapstyle.txt').then((string) {
      _mapStyle = string;
    });
  }

  //Build
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawerScrimColor: Color.fromARGB(10, 0, 0, 0),
        drawer: Container(
          height: size.height,
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: Color.fromARGB(70, 200, 200, 200),
            boxShadow: [],
          ),
          child: Stack(
            children: [
              SizedBox(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: [
                    Container(
                      height: 50.0,
                      width: size.width * 0.6,
                      color: Colors.red.withOpacity(0.3),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: Colors.red,
              child: GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                    mapController?.setMapStyle(_mapStyle);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
