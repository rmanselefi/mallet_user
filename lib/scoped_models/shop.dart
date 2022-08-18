import 'package:mallet_user/models/platform.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/connected_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin ShopModel on ConnectedModels {
  List<Shop> shops = [];
  List<Shop> topList = [];
  List<Platform> platforms = [];
  List<Shop> nearTopList = [];

  Future<dynamic> fetchShopByCategory(String mallId, String category) async {
    shops = selectedShops.where((s) => s.shopCategory == category).toList();
    return shops;
  }

  Future<List<Platform>> getPlatformImages() async {
    try {
      var docs = await FirebaseFirestore.instance.collection('platform').get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Platform platform = Platform(
            url: data.containsKey('image') ? data['image'] : '',
          );
          platforms.add(platform);
          notifyListeners();
        }
      }
      return platforms;
    } catch (error) {
      print('erroror $error');
    }
    return platforms;
  }
}
