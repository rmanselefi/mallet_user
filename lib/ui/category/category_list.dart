import 'package:flutter/material.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/category/category_detail.dart';

class CategoryList extends StatefulWidget {
  final mall;
  final MainModel? model;
  CategoryList({this.model, this.mall});
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    return Container(
      height: 90.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 10.0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: model!.distinctCats.length,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 20.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    model.fetchShopByCategory(widget.mall.Id,
                        model.distinctCats[index]['name'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryDetail(
                              model.distinctCats[index]['name'].toString())),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/placeholder.png'),
                      image: model.distinctCats[index]['image'] != ""
                          ? NetworkImage(
                              model.distinctCats[index]['image'],
                            )
                          : AssetImage('assets/place.png') as ImageProvider,
                      fit: BoxFit.fill,
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  model.distinctCats[index]['name'],
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
