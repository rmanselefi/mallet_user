import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class MallService extends ChangeNotifier {
  List<Mall> malls = [];
  List<Mall> nearMall = [];
  List<Shop> shops = [];
  List<Shop> topList = [];
  List<Shop> nearTopList = [];
  bool isLoading = true;

  // UserLocation currentLocation = UserLocation();
  //
  // // MallService(){
  // //   getCurrentLocation();
  // // }
  // UserLocation get getLoc => currentLocation;
  //
  // set setCurrentLocation(UserLocation value) {
  //   currentLocation = value;
  //   print("object ${value.latitude}");
  //   notifyListeners();
  // }
  List<Mall> get nearestMall => nearMall;
  Future<List<Mall>> fetchNearByMalls(UserLocation? currentLocation)  async {
    isLoading = true;
    malls.clear();
    nearMall.clear();

    try {
      var docs = await FirebaseFirestore.instance.collection('mall').get();
      if (docs.docs.isNotEmpty) {
        if (malls.isEmpty) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Mall mall = Mall(
                Id: docs.docs[i].id,
                mallName: data['mall_name'],
                mallSefer: data['mall_sefer'],
                mallLatitude: data['mall_location'].latitude,
                mallLongitude: data['mall_location'].longitude,
                mallImage: data['image']);
            malls.add(mall);
          }
        }
        if (nearMall.isEmpty) {
          for (var i = 0; i < malls.length; i++) {
            if (currentLocation != null) {
              var calcDist = Geolocator.distanceBetween(
                  currentLocation.latitude!.toDouble(),
                  currentLocation.longitude!.toDouble(),
                  malls[i].mallLatitude!.toDouble(),
                  malls[i].mallLongitude!.toDouble());
              malls[i].distance = calcDist;
              nearMall.add(malls[i]);
              isLoading = false;
            }
          }
        }
        if (nearMall.length != 0) {
          nearMall.sort((a, b) => a.distance!.compareTo(b.distance as num));
        }
      }
      notifyListeners();
      return nearMall;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return [];
    }
  }

  Future<List<Shop>> getTopProduct(UserLocation currentLocation) async {
    try {
      topList.clear();
      nearTopList.clear();
      var docs = await FirebaseFirestore.instance.collection('shop').get();
      if (topList.isEmpty) {
        if (docs.docs.isNotEmpty) {
          var topShops =
              docs.docs.where((sh) => sh.data()['isTop'] == true).toList();

          if (topList.isEmpty) {
            for (var i = 0; i < topShops.length; i++) {
              var data = topShops[i].data();
              final Shop shop = Shop(
                Id: topShops[i].id,
                shopName:
                    data.containsKey('shop_name') ? data['shop_name'] : '',
                shopFloorNumber: data.containsKey('floor_number')
                    ? data['floor_number']
                    : '',
                shopFloorName:
                    data.containsKey('floor_name') ? data['floor_name'] : '',
                shopRoomNumber:
                    data.containsKey('room_number') ? data['room_number'] : '',
                shopCategory: data.containsKey('category')
                    ? data['category']['name']
                    : '',
                back_image:
                    data.containsKey('back_image') ? data['back_image'] : '',
                shopMall: data.containsKey('mall') ? data['mall']['name'] : '',
                shopLatitude: data['location'].latitude,
                shopLongitude: data['location'].longitude,
              );
              topList.add(shop);
            }
          }
          if (nearTopList.length == 0) {
            for (var i = 0; i < topList.length; i++) {
              if (currentLocation != null) {
                var calcDist = Geolocator.distanceBetween(
                    currentLocation.latitude!.toDouble(),
                    currentLocation.longitude!.toDouble(),
                    topList[i].shopLatitude!.toDouble(),
                    topList[i].shopLongitude!.toDouble());
                topList[i].distance = calcDist;
                nearTopList.add(topList[i]);
                isLoading = false;
              }
            }
          }
          if (nearTopList.length != 0) {
            nearTopList.sort((a, b) => a.distance!.compareTo(int.parse(b.distance.toString())));
          }
          notifyListeners();
        }
      }
      return nearTopList;
    } catch (error) {
      isLoading = false;
      print("errortop $error");
      return [];
    }
  }

  // Future<UserLocation> getCurrentLocation() async {
  //   try {
  //     Position curr = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     currentLocation = UserLocation(
  //       latitude: curr.latitude,
  //       longitude: curr.longitude,
  //     );
  //     setCurrentLocation = currentLocation;
  //     notifyListeners();
  //     return currentLocation;
  //   } catch (e) {
  //     print('errorlocation $e');
  //   }
  // }
}
