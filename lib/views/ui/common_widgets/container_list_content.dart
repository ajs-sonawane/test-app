import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListContent extends StatelessWidget {
  final double imgHeight;
  final double imgWidth;
  final String imgURL;
  final String title;
  final String desc;
  final String countTitleONE;
  final String countTitleTWO;
  final String countTitleTHREE;
  final String countONE;
  final String countTWO;
  final String countTHREE;

  const ListContent(
      {Key key,
      this.imgHeight,
      this.imgURL,
      this.title,
      this.desc,
      this.countTitleONE,
      this.countTitleTWO,
      this.countTitleTHREE,
      this.countONE,
      this.countTWO,
      this.countTHREE, this.imgWidth})
      : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        // alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              imageContainer(),
              Container(
                color: Colors.tealAccent,
                height: 120.0,
              )
            ],
          ),
          Positioned(
            top: imgHeight-35,
            left: 0.0,
            right: 0.0,
            child: Container(

              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  floatingContainerONE(),
                  SizedBox(height: 20.0),
                  floatingContainerTWO(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      // color: Colors.cyan,
      height: imgHeight,
      width: imgWidth,
      child: CachedNetworkImage(
          placeholder: (context, url) => Image.asset("assets/images/placeholder.png",
          fit: BoxFit.cover,),
          imageUrl: imgURL, fit: BoxFit.cover),
    );
  }

  floatingContainerONE() {
    return Row(
      children: [
        SizedBox(width: 8.0),
        descContainer(),
        SizedBox(width: 12.0),
        circleContainer(),
        SizedBox(width: 12.0),
      ],
    );
  }

  descContainer() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
            left: 8.0,right: 8.0,
            bottom: 4.0,top: 4.0
        ),
        decoration:
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              // width: 300,
              // color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_title(), _fav()],
              ),
            ),
            _desc()
          ],
        ),
      ),
    );
  }

  _title() {
    return Text(title,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 13.0
    ),);
  }

  _fav() {
    return Container(

      child: IconButton(
          icon: Icon(
            Icons.favorite_sharp,
            color: Colors.red,
          ),
          onPressed: () {}),
    );
  }

  _desc() {
    return Text(desc,
        style: TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
            fontSize: 12.0
        ));
  }

  circleContainer() {
    return CircleAvatar(
      minRadius: 30,
      backgroundColor: Colors.teal,
      child: Text("100 %"),
    );
  }

  floatingContainerTWO() {
    return Container(
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _commonStatsContainer(countONE, countTitleONE),
          _commonStatsContainer(countTWO, countTitleTWO),
          _commonStatsContainer(countTHREE, countTitleTHREE),
          Container(
            padding: EdgeInsets.only(right: 8.0,left: 8.0,bottom: 4.0,top:4.0 ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Text(
              "PLEDGE",
              style: TextStyle(color: Colors.teal),
            ),
          )
        ],
      ),
    );
  }

  _commonStatsContainer(count, countTitle) {
    return Column(
      children: [
        Text(count),
        SizedBox(height: 8.0),
        Text(countTitle),
      ],
    );
  }
}
