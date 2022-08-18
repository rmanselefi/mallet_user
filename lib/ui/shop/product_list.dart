import 'package:flutter/material.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/product/product_detail.dart';
import 'package:mallet_user/ui/shop/shopdetail_card.dart';
import 'package:mallet_user/widgets/seeall_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          if (model.selectedProduct.length != 0 && !model.isLoading) {
            return Container(
                padding: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(color: Color(0xff2a2e42)),
                child: Column(
//              shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Availables',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeeAllPage(
                                      model: model,
                                    )),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(
                                'SEE ALL',
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: model.getShopById,
                          child: ResponsiveGridList(
                              minSpacing: 5,
                              desiredItemWidth:
                              MediaQuery.of(context).size.width > 370
                                  ? 180
                                  : 120,
                              scroll: true,
                              children: model.selectedProduct.map<Widget>((f) {
                                return f.productImage != ''
                                    ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
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
                        ),
                      )
                    ]));
          } else if (model.selectedProduct.length == 0 && !model.isLoading) {
            return Center(
              child: Text('No product to show'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
