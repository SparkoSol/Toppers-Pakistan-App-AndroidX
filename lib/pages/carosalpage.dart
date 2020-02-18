import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topperspakistan/models/carosel_model.dart';
import 'package:topperspakistan/services/carosel_service.dart';

import '../simple-future-builder.dart';

class Carosal extends StatefulWidget {
  @override
  _CarosalState createState() => _CarosalState();
}

class _CarosalState extends State<Carosal> {
  final _caroselService = CaroselService();

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder<List<CaroselModel>>.simpler(
        future: _caroselService.fetchAll(),
        context: context,
        builder: (AsyncSnapshot<List<CaroselModel>> snapshot) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text("No Images Found"),
            );
          } else {
            return CarouselSlider(
              height: 200.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
              items: snapshot.data.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.network(
                        "http://nabeel-pc:8000/images/carosel/" +
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
