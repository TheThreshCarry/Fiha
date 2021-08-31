import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconHandeler {
  static Map<int, BitmapDescriptor> icons = {};
  static Map<int, BitmapDescriptor> getIcons() {
    ImageConfiguration configuration = ImageConfiguration.empty;
    BitmapDescriptor.fromAssetImage(configuration, "assets/icons/music.png")
        .then((value) => icons[0] = value);
    BitmapDescriptor.fromAssetImage(configuration, "assets/icons/sport.png")
        .then((value) => icons[1] = value);
    BitmapDescriptor.fromAssetImage(
            configuration, "assets/icons/restaurant.png")
        .then((value) => icons[2] = value);
    return icons;
  }
}

final Map<int, String> intToCategory = {
  0: "Music",
  1: "Sport",
  2: "Culture",
};
