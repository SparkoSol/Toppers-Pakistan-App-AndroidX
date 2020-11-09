import 'package:flutter/material.dart';
import 'package:topperspakistan/models/notification_model.dart';
import 'package:topperspakistan/services/notification_service.dart';
import 'package:topperspakistan/simple-future-builder.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Notifications",
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
        body: SimpleFutureBuilder<List<NotificationModel>>.simpler(
            future: notificationService.fetchAll(),
            context: context,
            builder: (AsyncSnapshot<List<NotificationModel>> snapshot) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("No Notification Found"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            children: <Widget>[
                              Icon(Icons.notifications),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                snapshot.data[i].title,
                              )),
                            ],
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 35,
                              ),
                              Expanded(child: Text(snapshot.data[i].message)),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          indent: 10,
                          endIndent: 10,
                        )
                      ],
                    );
                  },
                );
              }
            }));
  }
}
