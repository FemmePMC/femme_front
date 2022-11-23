import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/back/manager.dart';
import 'package:best_flutter_ui_templates/main.dart';

// ignore: must_be_immutable
class NotificationPage extends StatelessWidget {
  User userService;
  NotificationPage(this.userService);

  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Notificaciones'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 158, 112, 162),
        ),
        body: FutureBuilder<List>(
            future: userService.getNotifications(),
            builder: (context, future) {
              if (!future.hasData)
                return Container();
              else {
                List? list = future.data;
                return ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      return contactCard(
                          list[index]["user"]["name"],
                          list[index]["user"]["photo"],
                          list[index]["message"],
                          list[index]["latitude"],
                          list[index]["longitude"]);
                    });
              }
            }),
      );

  Card contactCard(String name, String photo, String message, double latitude,
      double longitude) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(5),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(name),
            subtitle: Text(message),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(photo),
            ),
            trailing: Column(children: [
              Text(latitude.toString()),
              Text(longitude.toString()),
            ]),
            onTap: () => MapView(userService, latitude, longitude),
          ),
        ],
      ),
    );
  }
}
