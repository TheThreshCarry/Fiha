import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiha/main.dart';
import 'package:fiha/modals/Event.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

class DataHandeler {
  final geo = Geoflutterfire();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<DocumentSnapshot>> dataStream = Stream.empty();
  //getEvents Function
  void getEvents(Position position) async {
    var eventRef = _firestore.collection("events");
    GeoFirePoint center =
        geo.point(latitude: position.latitude, longitude: position.longitude);
    double radius = 30;
    const String field = 'position';

    dataStream = geo
        .collection(collectionRef: eventRef)
        .within(center: center, radius: radius, field: field);
    //Listen to the results
    dataStream.listen((List<DocumentSnapshot> documentList) {
      // got the geoquery data
      List<Event> resultsEvents = [];
      documentList.forEach((element) {
        Event event = Event.fromObject(element.data());
        resultsEvents.add(event);
      });
      print(
          "Had " + resultsEvents.length.toString() + " results for this query");
      dataToMarkers(resultsEvents);
    });
  }

  void filterEvents(Object options) {}
}
