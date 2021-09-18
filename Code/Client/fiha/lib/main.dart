import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiha/modals/Event.dart';
import 'package:fiha/screens/eventPage.dart';
import 'package:fiha/services/dataHandeler.dart';
import 'package:fiha/services/iconsHandeler.dart';
import 'package:fiha/widgets/GlassDrawer.dart';
import 'package:fiha/widgets/event_miniplayer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "services/locationHandeler.dart";
import 'package:flutter/services.dart' show SystemChrome, rootBundle;
//My Functions

DataHandeler? dataHandeler;
Position? position;
List<Marker> markers = [];
List<Event> events = [];
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final selectedEventProvider = StateProvider<Event?>((ref) => null);
final providerContainer = ProviderContainer();

Map<int, BitmapDescriptor> iconsMap = {};
List<String> categories = [
  "Musique",
  "Nourriture",
  "Sport",
  "Literatture",
  "Camping"
];
final Map<String, String> categoriesIcons = {
  "Musique": 'assets/icons/music.png',
  "Nourriture": 'assets/icons/restaurant.png',
  "Sport": 'assets/icons/sport.png',
  "Camping": 'assets/icons/camping.png',
  "Literatture": 'assets/icons/book.png'
};

CameraPosition _cameraPosition = CameraPosition(
  target: LatLng(36.7642, 3.188),
  zoom: 12,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(UncontrolledProviderScope(
    child: MyApp(),
    container: providerContainer,
  ));
}

//Data
Future<dynamic> initiliazeApp(context) async {
  await Firebase.initializeApp().whenComplete(() async {
    await determinePosition().then((value) {
      print(value);
      _cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 12);
      DataHandeler.position = value;
      return position = value;
    }).catchError((err) {
      print(err);
    });
    dataHandeler = DataHandeler();
    iconsMap = IconHandeler.getIcons();
    dataHandeler?.getEvents(position!);
  });
}

//Set Markers

//MapResultsToMarkers
void dataToMarkers(List<Event> results) {
  markers = [];

  results.forEach((event) {
    GeoPoint point = event.point;
    markers.add(
      Marker(
          markerId: MarkerId(point.hashCode.toString()),
          position: LatLng(point.latitude, point.longitude),
          icon: iconsMap[event.type]!,
          //Action on Tap
          onTap: () {
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => EventPage(event: event),
              ),
            );
            /*providerContainer.read(selectedEventProvider).state = event;
            print(providerContainer.read(selectedEventProvider).state?.name);*/
          }),
    );

    //Tets Marker for looking at positoion
    markers.add(Marker(
      markerId: MarkerId("32323264"),
      position: LatLng(position!.latitude, position!.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiha',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "Poppins",
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
        extendBodyBehindAppBar: true,
        drawerScrimColor: Color.fromARGB(10, 50, 50, 50),
        drawer: GlassDrawer(size: size),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: initiliazeApp(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _cameraPosition = CameraPosition(
                  target: LatLng(position!.latitude, position!.longitude),
                  zoom: 14.5);

              return Stack(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    child: StreamBuilder(
                      stream: dataHandeler!.dataStream,
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return GoogleMap(
                            initialCameraPosition: _cameraPosition,
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                              mapController?.setMapStyle(_mapStyle);
                            },
                            markers: markers.toSet(),
                          );
                        } else {
                          return Container(
                            height: size.height,
                            width: size.width,
                            color: Color(0xFFF1FAEE),
                          );
                        }
                      },
                    ),
                  ),
                  Consumer(builder: (context, ref, _) {
                    Event? event = ref(selectedEventProvider).state;
                    if (event != null) print("Actual Event : " + event.name);
                    if (event != null) {
                      return Positioned(
                        child: EventMiniPlayer(event: event),
                        bottom: 0.0,
                        width: MediaQuery.of(context).size.width,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

//Drawer Class For my Custom Drawer
