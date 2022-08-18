import 'package:flutter/material.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/product/product_detail.dart';
import 'package:mallet_user/ui/shop/shopdetail_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SeeAllPage extends StatefulWidget {
  final MainModel? model;

  SeeAllPage({this.model});

  @override
  _SeeAllPageState createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
//  List<Product> allProducts=widget.model.allProducts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff2a2e42),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff29b6f6),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff2a2e42)
        ),
          padding: EdgeInsets.all(10.0),
          child: ResponsiveGridList(
              minSpacing: 5,
              desiredItemWidth: MediaQuery
                  .of(context)
                  .size
                  .width > 370 ? 180 : 120,
              scroll: true,
              children: widget.model!.allProducts.map<Widget>((f) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(product: f,)
                    ),
                    );
                  },
                  child: ShopDetailCard(name: f.productName,
                      price: f.productPrice,
                      url: f.productImage),
                );
              }).toList()
          )
      ),
    );
  }
}
