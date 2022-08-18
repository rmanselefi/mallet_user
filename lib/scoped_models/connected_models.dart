import 'package:mallet_user/models/product.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

mixin ConnectedModels on Model {
  bool isLoading = true;
  List<Shop> selectedShops = [];
  List<Product> selectedMallsProducts = [];
  UserLocation? currentLocation;
  List<Shop> shops = [];
  List<Shop> topList = [];
  List<Shop> nearTopList = [];

  Future<UserLocation?> getCurrentLocation() async {
    LocationPermission permission;
    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position curr = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation = UserLocation(
        latitude: curr.latitude,
        longitude: curr.longitude,
      );
      notifyListeners();
      return currentLocation;
    } catch (e) {
      print('errorlocation $e');
    }

    return currentLocation;
  }

  Future<List<Shop>?> getTopProduct() async {
    try {
      topList.clear();
      nearTopList.clear();
      var docs = await FirebaseFirestore.instance.collection('shop').get();
      var userLoc = await getCurrentLocation();
      if (topList.length == 0) {
        if (docs.docs.isNotEmpty) {
          var topShops =
              docs.docs.where((sh) => sh.data()['isTop'] == true).toList();

          if (topList.length == 0) {
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
          if (nearTopList.isEmpty) {
            for (var i = 0; i < topList.length; i++) {
              if (userLoc != null) {
                var calcDist = Geolocator.distanceBetween(
                    currentLocation!.latitude!.toDouble(),
                    currentLocation!.longitude!.toDouble(),
                    topList[i].shopLatitude!.toDouble(),
                    topList[i].shopLongitude!.toDouble());
                topList[i].distance = calcDist;
                nearTopList.add(topList[i]);
                isLoading = false;
              }
            }
          }
          if (nearTopList.length != 0) {
            nearTopList
                .sort((a, b) => a.distance!.compareTo(b.distance as num));
          }
        }
        notifyListeners();
      }
      return nearTopList;
    } catch (error) {
      isLoading = false;
      print("errortop $error");
      return null;
    }
  }
}
