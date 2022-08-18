import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/product/product_detail.dart';
import 'package:mallet_user/ui/shop/product_list.dart';
import 'package:mallet_user/ui/shop/shop_detail_info.dart';
import 'package:mallet_user/ui/shop/shopdetail_card.dart';
import 'package:mallet_user/ui/shop/top.dart';
import 'package:mallet_user/utils/ShopMode.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ShopDetail extends StatefulWidget {
  final Shop shop;
  final MainModel? model;

  const ShopDetail(this.shop, this.model);

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  ShopeMode _mode = ShopeMode.Home;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model!.getShopById();
    widget.model!.getShopDetail();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          // For Android.
          // Use [light] for white status bar and [dark] for black status bar.
          statusBarIconBrightness: Brightness.light,
          // For iOS.
          // Use [dark] for white status bar and [light] for black status bar.
          statusBarBrightness: Brightness.light,
        ),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration:BoxDecoration(
              color: Color(0xff2a2e42)
            ),
            child: Column(
              children: <Widget>[
                ShopDetailTop(shop: widget.shop),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _mode = ShopeMode.Home;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: _mode == ShopeMode.Home
                                      ? BorderSide(
                                          width: 2, color: Colors.lightBlue)
                                      : BorderSide(
                                          width: 2, color: Colors.white))),
                          child: Text(
                            'Home',
                            style: TextStyle(
                                color: _mode == ShopeMode.Home
                                    ? Colors.lightBlue
                                    : Colors.black26),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _mode = ShopeMode.Detail;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: _mode == ShopeMode.Detail
                                      ? BorderSide(
                                          width: 2, color: Colors.lightBlue)
                                      : BorderSide(
                                          width: 2, color: Colors.white))),
                          child: Text(
                            'Detail Info',
                            style: TextStyle(
                                color: _mode == ShopeMode.Detail
                                    ? Colors.lightBlue
                                    : Colors.black26),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _mode = ShopeMode.BigSell;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: _mode == ShopeMode.BigSell
                                      ? BorderSide(
                                          width: 2, color: Colors.lightBlue)
                                      : BorderSide(
                                          width: 2, color: Colors.white))),
                          child:  Text(widget.shop.shopCategory == 'Furniture' ||
                              widget.shop.shopCategory == 'Cloths/Apparel' || widget.shop.shopCategory == 'Stationary' ||
                              widget.shop.shopCategory == 'Materials' || widget.shop.shopCategory=='Electronics'
                              ? 'BIG Sale'
                              : 'Special', style: TextStyle(
                              color: _mode == ShopeMode.BigSell ? Colors
                                  .lightBlue : Colors.black26),),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Builder(builder: (context) {
                  if (_mode == ShopeMode.Home) {
                    return Expanded(child: ProductList());
                  } else if (_mode == ShopeMode.BigSell) {
                    return Expanded(
                      child: ScopedModelDescendant(builder:
                          (BuildContext context, Widget child, MainModel model) {
                        return RefreshIndicator(
                          onRefresh: widget.model!.getShopById,
                          child: ResponsiveGridList(
                              minSpacing: 5,
                              desiredItemWidth:
                                  MediaQuery.of(context).size.width > 370
                                      ? 180
                                      : 120,
                              scroll: true,
                              children: model.specialProducts.map<Widget>((f) {
                                return f.productImage != ''
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetail(
                                                      product: f,
                                                    )),
                                          );
                                        },
                                        child: ShopDetailCard(
                                            name: f.productName,
                                            price: f.productPrice,
                                            url: f.productImage),
                                      )
                                    : Container();
                              }).toList()),
                        );
                      }),
                    );
                  } else {
                    return ProductDetailInfo(
                      model:widget.model
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
