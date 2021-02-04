import 'package:flutter/material.dart';
import 'package:topperspakistan/models/branch_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/first.dart';
import 'package:topperspakistan/services/branch_service.dart';

import '../simple-future-builder.dart';

class Branch extends StatefulWidget {
  @override
  _BranchState createState() => _BranchState();
}

class _BranchState extends State<Branch> {
  final _BranchService = BranchService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Branch",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Image.asset('images/ApnaStore.png'),
            iconSize: 80.0,
            onPressed: null,
          ),
        ],
      ),
      body: SimpleFutureBuilder<List<BranchModel>>.simpler(
        future: _BranchService.fetchAll(),
        context: context,
        builder: (AsyncSnapshot<List<BranchModel>> snapshot) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Branches Found'),
                  Text('Come back after a while.'),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(28.0),
                    ),
                    color: Color(0xffCE862A),
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => {
                    print('call branch set'),
                    print(snapshot.data[i].toJson()),
                    LocalData.setBranch(snapshot.data[i]),
                    print(LocalData.branchId),
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => First()), (route)=>false)
                  },
                  child: Card(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                              child: snapshot.data[i].image != null
                                  ? Image.network(
                                      "https://api.apnapos.pk/images/branch/" +
                                          snapshot.data[i].image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'images/ApnaStore.png',
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
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
