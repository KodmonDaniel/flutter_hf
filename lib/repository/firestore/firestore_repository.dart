import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hf/repository/firestore/models/stored_weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/models/city_response.dart';
import 'models/user_details.dart';

class FirestoreRepository {
  FirestoreRepository();

  /// City weather stream
  final citiesResponseController = StreamController<List<StoredWeather>?>.broadcast();
  Stream<List<StoredWeather>?> get cityResponse => citiesResponseController.stream;

  final userDetailsController = StreamController<UserDetails?>.broadcast();
  Stream<UserDetails?> get userDetails => userDetailsController.stream;

  final userRoleController = StreamController<bool?>.broadcast();
  Stream<bool?> get userRole => userRoleController.stream;

  /// Dispose
  void dispose(){
    citiesResponseController.close();
    userDetailsController.close();
    userRoleController.close();
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

  /// Get the user details from a usernape or an email
   Future<UserDetails?> getUserDetails(String? name, String? email) async {
     var completer = Completer<UserDetails?>();
     try {
       FirebaseFirestore firestore = FirebaseFirestore.instance;
      late dynamic querySnapshot;
      if (name != null) { querySnapshot = await firestore.collection('users').where('username', isEqualTo: name).get();}
      else if (email != null) { querySnapshot = await firestore.collection('users').where('email', isEqualTo: email).get();}

       //final querySnapshot = await firestore.collection('users').where('username', isEqualTo: name).get();
       var details = UserDetails.fromJson(querySnapshot.docs.first.data());

       print(details.username);
       print(details.email);
       print(details.admin);

       userDetailsController.sink.add(details);
       completer.complete(details);
       return completer.future;
     } catch (error) {
       completer.complete(null);
       return completer.future;
     }
   }
/*
  Future<bool?> getRole(String email) async {
    var completer = Completer<bool?>();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('users').where('email', isEqualTo: email).get();
      var details = UserDetails.fromJson(querySnapshot.docs.first.data());
       var role = details.admin;

      userRoleController.sink.add(role);
      completer.complete(role);
      return completer.future;
    } catch (error) {
      print(error.toString() + "    <---");
      completer.complete(null);
      return completer.future;
    }
  }*/

  Future signIn(String email, String pwd) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: pwd);
  }
}

