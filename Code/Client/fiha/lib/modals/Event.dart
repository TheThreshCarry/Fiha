import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final String organizer;
  final String description;
  final double price;
  final int type;
  final int actionType;
  final int remainingPlaces;
  final int totalPlaces;
  final GeoPoint point;
  final String geohash;
  final String phoneNumber;
  final List<dynamic> imgs;
  final Timestamp startDate;
  final Timestamp? endDate;

  Event(
      this.name,
      this.organizer,
      this.description,
      this.price,
      this.type,
      this.actionType,
      this.point,
      this.geohash,
      this.phoneNumber,
      this.imgs,
      this.remainingPlaces,
      this.totalPlaces,
      this.startDate,
      this.endDate);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'organizer': organizer,
      'description': description,
      'price': price,
      'type': type,
      'actionType': actionType,
      'point': {"lat": point.latitude, "long": point.longitude},
      'geohash': geohash,
      'phoneNumber': phoneNumber,
      'remainingPlaces': remainingPlaces,
      'totalPlaces': totalPlaces,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      map['name'],
      map['organizer'],
      map['description'],
      map['price'],
      map['type'],
      map['actionType'],
      map['position']['geopoint'],
      map['geohash'],
      map['phoneNumber'],
      map['imgs'],
      map['remainingPlaces'],
      map['totalPlaces'],
      map['startDate'],
      map['endDate'],
    );
  }
  factory Event.fromObject(Object? object) {
    dynamic map = object;
    return Event(
      map['name'],
      map['organizer'].toString(),
      map['description'],
      double.parse(map['price'].toString()),
      map['type'],
      map['submitedAction'],
      map['position']['geopoint'],
      map['position']['geohash'],
      map['phoneNumber'],
      map['imgs'],
      map['remainingPlaces'],
      map['totalPlaces'],
      map['startDate'],
      map['endDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
