import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DataHandeler {
  final geo = Geoflutterfire();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void getEvents() async {
    var eventRef = _firestore.collection("events");

    GeoFirePoint center = geo.point(latitude: 36.3733015, longitude: 6.6218766);
    double radius = 50000;
    String field = 'position';
    //print("my Location Data : " + center.data);
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: eventRef)
        .within(center: center, radius: radius, field: field);
    //Listen to the results
    stream.listen((List<DocumentSnapshot> documentList) {
      if (documentList.isEmpty) {
        print("didnt find any document !");
      } else {
        // got the geoquery data

      }
    });
  }
}
