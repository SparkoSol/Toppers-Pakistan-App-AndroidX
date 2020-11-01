import 'package:flutter/material.dart';
import 'package:topperspakistan/models/category_model.dart';
import 'package:topperspakistan/models/subCategories_model.dart';
import 'package:topperspakistan/services/subCategory_service.dart';
import 'package:topperspakistan/simple-future-builder.dart';

import 'order.dart';

class SubCategories extends StatefulWidget {
  final CategoryModel categoryModel;

  SubCategories({this.categoryModel});

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  final subCategoryService = SubCategoryService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
              appBar: AppBar(
        title: Text("Sub Categories",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
            new IconButton(
            icon: new Image.asset('images/LogoTrans.png'),
            iconSize: 80.0,
            onPressed: null,
          ),
          ],
      ),
        body: SimpleFutureBuilder<List<SubCategoryModel>>.simpler(
            future:
                widget.categoryModel.fetchSubCategory(widget.categoryModel.id),
            context: context,
            builder: (AsyncSnapshot<List<SubCategoryModel>> snapshot) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("No Sub Categories Found"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Order(
                            subCategoryModel: snapshot.data[i],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  "https://toppers-pakistan.toppers-mart.com/images/subCategory/" +
                                      snapshot.data[i].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data[i].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
