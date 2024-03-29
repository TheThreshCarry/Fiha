import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiha/modals/Filter.dart';
import 'package:fiha/screens/filterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fiha/main.dart';
import 'package:fiha/modals/Event.dart';
import 'package:intl/intl.dart';

class DataHandeler {
  final geo = Geoflutterfire();
  static Position? position;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<DocumentSnapshot>> dataStream = Stream.empty();
  Stream<List<DocumentSnapshot>> filterDataStream = Stream.empty();
  //getEvents Function
  void getEvents(Position position) async {
    var eventRef = _firestore.collection("events");
    GeoFirePoint center =
        geo.point(latitude: position.latitude, longitude: position.longitude);
    double radius = 20;
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

  //Filters
  Future<void> getFilterEvents(Filter options) async {
    var eventRef = _firestore.collection("events");

    GeoFirePoint center = geo.point(
        latitude: DataHandeler.position!.latitude,
        longitude: DataHandeler.position!.longitude);
    double radius = options.radius;
    const String field = 'position';
    if (options.radius == 100.0) {
      options.radius = 5000;
    }
    if (options.endDate == null) {
      options.endDate = DateTime(2222, 9, 7, 17, 30);
    }

    filterDataStream = geo
        .collection(collectionRef: eventRef)
        .within(center: center, radius: radius, field: field);
    List<Event> resultsEvents = [];
    //Listen to the results
    filterDataStream.listen((List<DocumentSnapshot> documentList) {
      // got the geoquery data

      documentList.forEach((element) {
        //Convert to Event
        Event event = Event.fromObject(element.data());
        print(intToCategory[event.type]! + " and " + options.category);
        //Filter
        if (event.endDate!.toDate().isBefore(options.endDate!) &&
            event.price < options.price &&
            (intToCategory[event.type] == options.category ||
                options.category == '-99') &&
            (event.name.contains(
                    RegExp(options.inputText, caseSensitive: false)) ||
                event.description.contains(
                    RegExp(options.inputText, caseSensitive: false)))) {
          resultsEvents.add(event);
        }
      });
      print("finished");
      getFilterResults(resultsEvents);
    });
  }
}
