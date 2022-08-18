import 'package:flutter/material.dart';
import 'package:mallet_user/models/product.dart';
import 'package:mallet_user/ui/product/top_productdetail.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;
  ProductDetail({this.product});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    var product = widget.product;
    return SafeArea(
        child: Scaffold(
            body: Container(
              height:double.infinity,
                child: ListView(
                  shrinkWrap: true,
                    children: [
                      ProductDetailTop(product: product,),
                      Divider(color: Colors.grey,),

                      ListTile(
                        title: Text('Product Name',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,),),
                        subtitle: Text(product!.productName.toString(),style: TextStyle(color: Colors.grey),),
                        dense: true,
                      ),
                      Divider(),
//                      Row(
//                        children: <Widget>[
//                          SizedBox(width: 15.0,),
//                          Text('Name',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
//                          SizedBox(width: 25.0,),
//                          Expanded(child: Text(product.productName,style: TextStyle(color: Colors.grey),))
//                        ],
//                      ),

                      ListTile(
                        title: Text('Price',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,),),
                        subtitle: Text(product.productPrice.toString(),style: TextStyle(color: Colors.grey),),
                        dense: true,
                      ),
//                      Row(
//                        children: <Widget>[
//                          Container(
//                            padding: EdgeInsets.only(left: 15.0),
//                              child: Text('Price',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),)
//                          ),
//                          Container(
//                            padding: EdgeInsets.only(left: 25.0),
//                              child: Text('${product.productPrice}',
//                                style: TextStyle(color: Colors.green,fontSize: 20.0,fontWeight: FontWeight.bold),)
//                          )
//                        ],
//                      ),
                      Divider(height: 25.0,),
                      ListTile(
                        title: Text('Description',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,),),
                        subtitle: Text(product.productDescription.toString(),style: TextStyle(color: Colors.grey),),
                      ),
//                      Row(
//                        children: <Widget>[
//                          SizedBox(width: 15.0,),
//                          Text('Description',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
//                          SizedBox(width: 25.0,),
//                          Expanded(child: Text(product.productDescription,style: TextStyle(color: Colors.grey),))
//                        ],
//                      ),
//                      SizedBox(height: 25.0,),
//                      Row(
//                        children: <Widget>[
//                          SizedBox(width: 15.0,),
//                          Text('Contact',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
//                          SizedBox(width: 25.0,),
//                          Expanded(child: Text(product.contact,style: TextStyle(color: Colors.grey),))
//                        ],
//                      ),
                      Divider(height: 50.0,color: Colors.grey,),

                    ]
                )
            )
        )
    );
  }
}
