import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/mall_images.dart';
import 'package:mallet_user/models/product.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/connected_models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

mixin MallModel on ConnectedModels {
  List<Mall> malls = [];
  List<Mall> nearMall = [];
  List<Shop> nearShop = [];
  List<Mall> mallName = [];
  List<Shop> shopName = [];
  List<Product> productName = [];
  String? selectedIndex;
  String? selectedShopId;
  List selectedCategories = [];
  List selectedFloors = [];
  List distinctCats = [];
  List<Shop> distinctFloorNum = [];
  List<Shop> floorNum = [];
  List<Product> selectedProduct = [];
  List<Product> specialProducts = [];
  List<Product> allProducts = [];
  Shop? shop;
  List<MallImages> mallImages = [];

  Future<List<Mall>>? fetchNearByMalls() async {
    isLoading = true;
    malls.clear();
    nearMall.clear();
    var curr;
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
                  currentLocation!.latitude!.toDouble(),
                  currentLocation!.longitude!.toDouble(),
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
      return nearMall;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return [];
    }
  }

  Future<List<MallImages>> fetchMallImages(String id) async {
    mallImages.clear();
    try {
      var images = await FirebaseFirestore.instance
          .collection('mall_images')
          .where('mall_id', isEqualTo: id)
          .get();
      for (var i = 0; i < images.docs.length; i++) {
        var data = images.docs[i].data();
        MallImages img = MallImages(
          image: data.containsKey('image') ? data['image'] : '',
        );
        mallImages.add(img);
      }
      notifyListeners();
      return mallImages;
    } catch (e) {
      return [];
    }
  }

  void selectMall(String index) {
    selectedIndex = index;
    notifyListeners();
  }

  void selectShop(String index) {
    selectedShopId = index;
    notifyListeners();
  }

  List<Mall>? get selectedMall {
    if (selectedIndex == null) {
      return null;
    }
    var mall = nearMall.where((m) => m.Id!.contains(selectedIndex.toString())).toSet();
    return mall.toList();
  }

  Future<dynamic> fetchNearShops(List<Shop> filteredShops) async {
    try {
      var _locationData = await getCurrentLocation();
      if (nearMall.length == 0) {
        for (var i = 0; i < filteredShops.length; i++) {
          var calcDist = Geolocator.distanceBetween(
              _locationData!.latitude!.toDouble(),
              _locationData.longitude!.toDouble(),
              filteredShops[i].shopLatitude!.toDouble(),
              filteredShops[i].shopLongitude!.toDouble());
          filteredShops[i].distance = calcDist;
          nearShop.add(filteredShops[i]);
          isLoading = false;
        }
      }
      if (nearShop.length != 0) {
        nearShop.sort((a, b) => a.distance!.compareTo(b.distance as num));
        notifyListeners();
      }
    } catch (e) {
      print('erororo $e');
    }
  }

  Future<dynamic> fetchMallNames() async {
    isLoading = true;
    try {
      var docs = await FirebaseFirestore.instance.collection('mall').get();
      var shops = await FirebaseFirestore.instance.collection('shop').get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Mall mall = Mall(
              Id: docs.docs[i].id,
              mallName: data.containsKey('mall_name') ? data['mall_name'] : '',
              mallSefer:
                  data.containsKey('mall_sefer') ? data['mall_sefer'] : '',
              mallLatitude: data.containsKey('mall_location')
                  ? data['mall_location'].latitude
                  : '',
              mallLongitude: data.containsKey('mall_location')
                  ? data['mall_location'].longitude
                  : '',
              mallImage: data['image']);
          mallName.add(mall);
          isLoading = false;
          notifyListeners();
        }
      }
      if (shops.docs.isNotEmpty) {
        for (var i = 0; i < shops.docs.length; i++) {
          var data = shops.docs[i].data();
          final Shop shop = Shop(
            Id: shops.docs[i].id,
            shopName: data.containsKey('shop_name') ? data['shop_name'] : '',
            shopRoomNumber:
                data.containsKey('room_number') ? data['room_number'] : '',
            shopFloorNumber:
                data.containsKey('floor_number') ? data['floor_number'] : '',
            shopFloorName:
                data.containsKey('floor_name') ? data['floor_name'] : '',
//              shopImage: data.containsKey('image')?data['image']:'',
            shopMall: data.containsKey('mall') ? data['mall']['name'] : '',
            shopCategory:
                data.containsKey('category') ? data['category']['name'] : '',
//            services: data.containsKey('shop_service')
//                ? data['shop_service']
//                : '',
            shopLatitude:
                data.containsKey('location') ? data['location'].latitude : '',
            shopLongitude:
                data.containsKey('location') ? data['location'].longitude : '',
            commonServiceName:
                data.containsKey('service_name') ? data['service_name'] : '',
            back_image:
                data.containsKey('back_image') ? data['back_image'] : '',
          );

          shopName.add(shop);
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (error) {
      isLoading = false;
      print("errorerrorerrorerrorerrorerror $error");
    }
  }

  Future<dynamic> fetchAllProducts() async {
    isLoading = true;
    try {
      var products =
          await FirebaseFirestore.instance.collection('product').get();
      if (products.docs.isNotEmpty) {
        for (var i = 0; i < products.docs.length; i++) {
          var data = products.docs[i].data();

          final Product product = Product(
            Id: products.docs[i].id,
            productName:
                data.containsKey('product_name') ? data['product_name'] : '',
//            productPrice: data.containsKey('product_price')?['product_price']:'',
            productImage: data.containsKey('image') ? data['image'] : '',
            productDescription: data.containsKey('product_description')
                ? data['product_description']
                : '',
            shopId: data.containsKey('shop') ? data['shop']['id'] : '',
          );

          productName.add(product);
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (error) {
      isLoading = false;
      print("errorerrorerrorerrorerrorerror $error");
    }
  }

  Future<dynamic> fetchProductsMall() async {
    isLoading = true;
    selectedMallsProducts.clear();
    try {
      if (selectedShops.length > 0) {
        for (int i = 0; i < selectedShops.length; i++) {
          selectedMallsProducts = selectedMallsProducts +
              productName
                  .where((s) => s.shopId!.contains(selectedShops[i].Id.toString()))
                  .toList();
        }

        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      print("errorerrorerrorerrorerrorerror $error");
    }
  }

  Future<Shop?> getShopDetail() async {
    try {
      var docs = await FirebaseFirestore.instance
          .collection('shop')
          .doc(selectedShopId)
          .get();
      var data = docs.data();

      shop = Shop(
          Id: selectedShopId.toString(),
          shopName: data!.containsKey('shop_name') ? data['shop_name'] : '',
          shopCategory:
              data.containsKey('category') ? data['category']['name'] : '',
          shopPhone: data.containsKey('phone') ? data['phone'] : '',
          shopWebsite:
              data.containsKey('shop_website') ? data['shop_website'] : '',
          shopTelegram:
              data.containsKey('shop_telegram') ? data['shop_telegram'] : '',
          shopDescription:
              data.containsKey('description') ? data['description'] : '');
      return shop;
    } catch (e) {
      print("detailerroro $e");
    }
  }

  Future<dynamic> fetchShops() async {
    isLoading = true;
    selectedShops.clear();
    selectedCategories.clear();
    selectedMallsProducts.clear();
    try {
      var docs = await FirebaseFirestore.instance.collection('shop').get();
      if (docs.docs.isNotEmpty) {
        var doc = docs.docs
            .where((sh) => sh.data()['mall']['id'] == selectedIndex)
            .toList();

        isLoading = false;
        notifyListeners();
        for (var i = 0; i < doc.length; i++) {
          var data = doc[i].data();
          final Shop shop = Shop(
              Id: doc[i].id,
              shopName: data.containsKey('shop_name') ? data['shop_name'] : '',
              shopFloorNumber:
                  data.containsKey('floor_number') ? data['floor_number'] : '',
              shopFloorName:
                  data.containsKey('floor_name') ? data['floor_name'] : '',
              shopRoomNumber:
                  data.containsKey('room_number') ? data['room_number'] : '',
//              shopImage: data.containsKey('image')?data['image'][]:'',
              shopCategory:
                  data.containsKey('category') ? data['category']['name'] : '',
              commonServiceName:
                  data.containsKey('service_name') ? data['service_name'] : '',
              back_image:
                  data.containsKey('back_image') ? data['back_image'] : null,
              isTop: data.containsKey('isTop') ? data['isTop'] : null,
//              services: data.containsKey('shop_service')
//                  ? data['shop_service']
//                  : null,
              shopMall: data.containsKey('mall') ? data['mall']['name'] : null);

          selectedShops.add(shop);

          var cat = {
            'name': data['category']['name'],
            'image': data['category']['image']
          };
          var isFound =
              selectedCategories.where((ca) => ca['name'] == cat['name']);

          if (isFound.length == 0) {
            selectedCategories.add(cat);
          }
          final Shop floor = Shop(
            shopFloorNumber:
                data.containsKey('floor_number') ? data['floor_number'] : '',
            shopFloorName:
                data.containsKey('floor_name') ? data['floor_name'] : '',
          );
          var isFoundf =
              floorNum.where((ca) => ca.shopFloorName == floor.shopFloorName);

          if (isFoundf.length == 0) {
            floorNum.add(floor);
          }

          isLoading = false;
        }
        selectedShops
            .sort((a, b) => a.shopRoomNumber!.compareTo(b.shopRoomNumber.toString()));
        floorNum.sort((a, b) => int.parse(a.shopFloorNumber.toString())
            .compareTo(int.parse(b.shopFloorNumber.toString())));
        distinctCats = selectedCategories.toSet().toList();
        if (selectedShops.length > 0) {
          for (int i = 0; i < selectedShops.length; i++) {
            selectedMallsProducts = selectedMallsProducts +
                productName
                    .where((s) => s.shopId!.contains(selectedShops[i].Id.toString()))
                    .toList();
          }

          isLoading = false;
          notifyListeners();
        }
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      print("errorerrorerrorerrorerrorerror $error");
    }
  }

  Future<List<Product>?> getShopById() async {
    isLoading = true;
    try {
      selectedProduct.clear();
      specialProducts.clear();
      allProducts.clear();
      var docs = await FirebaseFirestore.instance.collection('product').get();
      if (docs.docs.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        var doc = docs.docs
            .where((sh) => sh.data()['shop']['id'] == selectedShopId)
            .toList();
        for (var i = 0; i < doc.length; i++) {
          var data = doc[i].data();
          if (data.containsKey('product_name') && data['product_name'] != '') {
            final Product product = Product(
              Id: doc[i].id,
              productName:
                  data.containsKey('product_name') ? data['product_name'] : '',
              productPrice: data.containsKey('product_price')
                  ? data['product_price']
                  : '',
              productImage: data.containsKey('image') ? data['image'] : '',
              productDescription: data.containsKey('product_description')
                  ? data['product_description']
                  : '',
              shopId: data.containsKey('shop') ? data['shop']['id'] : '',
              contact: data.containsKey('contact') ? data['contact'] : '',
              isNormal: data.containsKey('isNormal') ? data['isNormal'] : '',
            );
            var isNormal = data.containsKey('isNormal') ? data['isNormal'] : '';
            allProducts.add(product);
            if (isNormal) {
              selectedProduct.add(product);
            } else {
              specialProducts.add(product);
            }
          }

          isLoading = false;
          notifyListeners();
        }
      }
      getShopDetail();
    } catch (error) {
      isLoading = false;
      print("errorerrorerrorerrorerrorerror $error");
    }
  }

  List<dynamic>? uniqifyList(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      dynamic o = list[i].name;
      int index;
      // Remove duplicates
      do {
        index = list[i].indexOf(o, i + 1);
        if (index != -1) {
          list.removeRange(index, 1);
        }
      } while (index != -1);
      return list;
    }
  }
}
