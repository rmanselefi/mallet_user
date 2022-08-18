


class Shop{
  String? Id;
  String? shopName;
  String? shopFloorNumber;
  String? shopFloorName;
  String? shopRoomNumber;
  String? shopCategory;
  String? shopMall;
  List? services;
  String? back_image;
  String? commonServiceName;
  double? shopLatitude;
  double? shopLongitude;
  String? shopPhone;
  String? shopDescription;
  String? shopWebsite;
  String? shopTelegram;
  double? distance;
  bool? isTop;
  List<dynamic>? shopImage;
  Shop({this.shopTelegram,this.shopWebsite,this.shopPhone,this.shopDescription,this.commonServiceName,this.shopLatitude,this.shopLongitude,this.distance,this.isTop,this.shopName,this.shopFloorNumber,this.shopImage,this.shopRoomNumber,this.shopMall,this.shopCategory,this.shopFloorName,this.back_image,this.Id,this.services});

}