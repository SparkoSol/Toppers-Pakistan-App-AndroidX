import 'package:flutter/material.dart';
import 'package:topperspakistan/models/sale-order.dart';
import 'package:topperspakistan/orderhistory.dart/order-status.dart';
import 'package:date_format/date_format.dart';
import 'package:topperspakistan/services/sale-order_service.dart';
import 'package:topperspakistan/utils/connectivityService.dart';
import 'package:topperspakistan/utils/no-internet-widget.dart';

import '../../simple-future-builder.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final _service = SaleOrderService();
  bool isInternetConnected = false;

  @override
  Widget build(BuildContext context) {
    isInternetConnected = checkConnectionStatus(context);

    return !isInternetConnected
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                "ORDER HISTORY",
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
            body: Center(child: ShowNoInternet()))
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "ORDER HISTORY",
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
            body: SimpleFutureBuilder<List<SaleOrder>>.simpler(
              future: _service.fetchAllOrderByCustomerId(),
              context: context,
              builder: (AsyncSnapshot<List<SaleOrder>> snapshot) {
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                            child: ListTile(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderStatus(
                                        orderModel: snapshot.data[i]),
                                  ),
                                );
                                setState(() {});
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "ORDER ID # " +
                                        snapshot.data[i].id.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(snapshot.data[i].delivery > 0
                                      ? snapshot.data[i].deliveryStatus
                                      : 'Completed'),
                                ],
                              ),
                              title: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(_parseDate(DateTime.parse(
                                    snapshot.data[i].createdAt))),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 0,
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
  }

  _parseDate(DateTime date) {
    return formatDate(date, [d, '-', MM, '-', yyyy, '|', HH, ':', nn, am])
        .toString();
  }
}
