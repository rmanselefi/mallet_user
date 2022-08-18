import 'package:flutter/material.dart';
import 'package:mallet_user/ui/mall/mall_detail.dart';

class NearByView extends StatelessWidget {
  final malls;
  final model;
  NearByView({this.malls,this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 15.0,
            ),
            itemCount: malls.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  model.selectMall(malls[index].Id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MallDetail(malls[index], model)),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: malls[index].mallImage != ""
                                  ? NetworkImage(malls[index].mallImage)
                                  : AssetImage('assets/placeholder.png') as ImageProvider)),
                    ),
                    Positioned.fill(
                      top: 200.0,
                      child: Opacity(
                        opacity: 0.9,
                        child: Container(
                          height: 60.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    malls[index].mallName,
                                    style: const TextStyle(
                                      color: Color(0xff5a5d6e),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'SegoeUI',
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
