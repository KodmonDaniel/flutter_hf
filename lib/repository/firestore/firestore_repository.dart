import 'dart:async';

import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  FirestoreRepository();


  /// City weather stream
  final citiesResponseController = StreamController<List<StoredWeather>?>.broadcast();
  Stream<List<StoredWeather>?> get cityResponse => citiesResponseController.stream;

  /// Dispose
  void dispose(){
    citiesResponseController.close();
  }

  Future<List<StoredWeather>?> getWeatherList() async {

    var completer = Completer<List<StoredWeather>?>();
    try {

   /* FirebaseFirestore firestore = FirebaseFirestore.instance;
  //  final user = FirebaseAuth.instance.currentUser;
    final userData = await firestore.collection('weather').orderBy('timestamp', descending: true).get();
    //var faves = userData.get('weather');
                 //return userData.map((jsonData) => StoredWeather.fromJson(jsonData)).toList();
   // return faves.map((jsonData) => StoredWeather.fromJson(jsonData)).toList();
*/


    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userData = await firestore.collection('weather').orderBy("time", descending: true).get();
    var list =  userData.docs.map((jsonData) => StoredWeather.fromJson(jsonData.data())).toList();

   /* FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userData = await firestore.collection('weather').get();
    var list =  userData.docs.map((jsonData) => StoredWeather.fromJson(jsonData.data())).toList();
*/

    citiesResponseController.sink.add(list);
    completer.complete(list);
    return completer.future;
    } catch (error) {
      completer.complete(null);
      return completer.future;
    }
  }


 wasd() {
   late List<StoredWeather> list = [];

   FirebaseFirestore.instance
       .collection('weather')
       .orderBy("time", descending: true)
       .get()
       .then((QuerySnapshot querySnapshot) {
     querySnapshot.docs.forEach((doc) {
       StoredWeather element = StoredWeather.fromJson(doc.data() as Map<String, dynamic>);
       list.add(element);
       print(element.city);
     });
   });
 }





}

/*
Stream<List<StoredWeather>> getWeatherList() =>
    FirebaseFirestore.instance
        .collection('weather')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => StoredWeather.fromJson(doc.data())).toList());


*/

//}