import 'package:flutter/material.dart';
import 'package:mallet_user/models/product.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/mall/mall_detail.dart';
import 'package:mallet_user/ui/shop/shop_detail.dart';
import 'package:scoped_model/scoped_model.dart';

class DataSearch extends SearchDelegate<String> {
  DataSearch():super(searchFieldLabel:"Search Buildings,Services....");

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color: Color(0xff29b6f6),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Color(0xff29b6f6),
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults();
  }


  Widget _buildResults() {
    return query == ''
        ? Container(
            child: Center(
              child: Text('Write something to search'),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  if (model.mallName.length == 0 &&
                      model.shopName.length == 0 &&
                      model.productName.length == 0) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final filtered = model.mallName
                      .where((p) => p.mallName!.toLowerCase().contains(query))
                      .toList();
                  final filteredWithLocation = model.mallName
                      .where((p) => p.mallSefer!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  List combined = filtered + filteredWithLocation;
                  List combinedNorep = combined.toSet().toList();

//
                  List<Shop> filteredShop = model.shopName
                      .where((p) => p.shopName!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  List<Shop> filteredShopCat = model.shopName
                      .where((p) => p.shopCategory!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  List<Shop> filteredShopCommonService = model.shopName
                      .where((p) => p.commonServiceName!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
//                  List<Shop> filteredWithService=[];
//                  for(int i=0;i<model.shopName.length;i++){
//                    final fil=model.shopName[i].services.where((s)=>s.toLowerCase().contains(query.toLowerCase())).toList();
//                    if(fil.length>0){
//                      filteredWithService.add(model.shopName[i]);
//                    }
//                  }
                  List<Product> filteredp = model.productName.where((p) => p.productName!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
//
                  List<Shop> filteredWithProduct=[];
                  for(int i=0;i<filteredp.length;i++){
                     filteredWithProduct=filteredWithProduct+model.shopName.where((s)=>s.Id!.contains(filteredp[i].shopId.toString())).toList();
                  }

//                  final filteredWithService=model.shopName.where((s)=>s.services.contains(query)).toList();
                  List<Shop> combinedShop=filteredShop+filteredShopCat+filteredShopCommonService+filteredWithProduct;
                  List<Shop> combinedShopNoRep=combinedShop.toSet().toList();


                  if (combinedShopNoRep.length == 0 && combinedNorep.length == 0) {
                    return const Center(
                      child: Text('No Results Found, Please try again'),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      combinedNorep.length != 0?
                      Container(
                        height: 20.0,
                        width: MediaQuery.of(context).size.width,
                        child: Text('Buildings',style:TextStyle(
                            color:Colors.white
                        )),
                        decoration: BoxDecoration(
                          color: Color(0xff2a2e42),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ):Container(),
                      SizedBox(
                        height: 5.0,
                      ),
                      Column(
                          children: combinedNorep
                              .map<Widget>(
                                (a) => ListTile(
                                  onTap: () {
                                    model.selectMall(a.Id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MallDetail(a, model)),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        a.mallImage.length != 0
                                            ? NetworkImage(a.mallImage[0])
                                            : AssetImage('assets/place.png') as ImageProvider,
                                  ),
                                  title: Text(a.mallName),
                                  subtitle: Text(a.mallSefer),
                                ),
                              )
                              .toList()),
                      SizedBox(
                        height: 5.0,
                      ),
                      combinedShopNoRep.length != 0? Container(
                        height: 20.0,
                        width: MediaQuery.of(context).size.width,
                        child: Text('Shops and services',style:TextStyle(
                          color:Colors.white
                        )),
                        decoration: BoxDecoration(
                          color: Color(0xff2a2e42),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                      ):Container(),
                      SizedBox(
                        height: 5.0,
                      ),
                      Column(
                          children: combinedShopNoRep
                              .map<Widget>(
                                (a) => ListTile(
                                  onTap: () {
                                    model.selectShop(a.Id.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShopDetail(a, model)),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: a.back_image != ''
                                        ? NetworkImage(a.back_image.toString())
                                        : AssetImage('assets/place.png') as ImageProvider,
                                  ),
                                  title: Text(a.shopName.toString()),
                                  subtitle: Text(
                                      "${a.shopFloorName} floor, ${a.shopMall}"),
                                ),
                              )
                              .toList()),
                      const SizedBox(
                        height: 5.0,
                      ),

                    ],
                  );
                })
              ],
            ),
          );
  }
}
