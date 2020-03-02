import 'package:flutter/material.dart';
import 'package:topperspakistan/drawer/account/add-address.dart';
import 'package:topperspakistan/models/address_model.dart';
import 'package:topperspakistan/services/addresses_service.dart';

import '../../cart_list.dart';
import '../../simple-future-builder.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _service = AddressService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddAddress()));
          }),
      appBar: AppBar(
        title: Text(
          "Address",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Image.asset('images/ToppersPakistanLogo.png'),
            onPressed: null,
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: SimpleFutureBuilder<List<AddressModel>>.simpler(
        future: _service.fetchAllByCustomerId(),
        context: context,
        builder: (AsyncSnapshot<List<AddressModel>> snapshot) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text('No data Found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      title: Text(snapshot.data[i].description),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data[i].house +
                              ", " +
                              snapshot.data[i].street +
                              ", " +
                              snapshot.data[i].area),
                          Text("Phone:" + snapshot.data[i].mobile),
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _service.delete(snapshot.data[i]);
                            setState(() {});
                          }),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
