import 'dart:async';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/models/city_response.dart';

class FirestoreRepository {
  FirestoreRepository();

  /// City weather stream
  final citiesResponseController = StreamController<List<StoredWeather>?>.broadcast();
  Stream<List<StoredWeather>?> get cityResponse => citiesResponseController.stream;

  /// Dispose
  void dispose(){
    citiesResponseController.close();
  }

  /// Gets saved city weather data from firestore
  Future<List<StoredWeather>?> getWeatherList() async {
    var completer = Completer<List<StoredWeather>?>();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('weather').orderBy("time", descending: true).get();
      var list = querySnapshot.docs.map((jsonData) => StoredWeather.fromJson(jsonData.data())).toList();
      citiesResponseController.sink.add(list);
      completer.complete(list);
      return completer.future;
      } catch (error) {
        completer.complete(null);
        return completer.future;
    }
  }

  ///EZJÓ de ua.
  /*Future<List<CartItem>> _getCartList() async {
    final querySnapshot = await FirebaseFirestore.instance.
    collection('OrderID').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final cartList = docs.map((doc) =>
        CartItem.fromJson(doc.data())).toList();
    return cartList;
  }*/

  /// Saves the current city weathers to firestore
  Future saveWeather(List<CityResponse> listToSave) async {
     for(CityResponse element in listToSave) {
      await FirebaseFirestore.instance.collection('weather').doc()
          .set(StoredWeather.toJson(element));
    }
 }
}

