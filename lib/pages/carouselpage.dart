  import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:topperspakistan/models/carousel_model.dart';
import 'package:topperspakistan/services/carousel_service.dart';

import '../simple-future-builder.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final _CarouselService = CarouselService();

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder<List<CarouselModel>>.simpler(
        future: _CarouselService.fetchAll(),
        context: context,
        builder: (AsyncSnapshot<List<CarouselModel>> snapshot) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text("No Images Found"),
            );
          } else {
            return CarouselSlider(
              height: 200.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: false,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
              items: snapshot.data.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    print("https://api.toppers-mart.com/images/carousel/" +
                        imgUrl.image);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.network(
                        "https://api.toppers-mart.com/images/carousel/" +
                            imgUrl.image,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        });
  }
}
