import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class CityMarker {
  AssetImage icon;
  String temp;
  String name;
  LatLng location;
  String apiId;

  CityMarker(this.icon, this.temp, this.name, this.location, this.apiId);
}

