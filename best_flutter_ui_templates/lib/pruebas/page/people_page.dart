import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/back/manager.dart';

class PeoplePage extends StatelessWidget {
  User userService = User();

  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Contactos'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 158, 112, 162),
        ),
        body: FutureBuilder<List>(
            future: userService.getUsers(),
            builder: (context, future) {
              if (!future.hasData)
                return Container();
              else {
                List? list = future.data;
                return ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      return contactCard(list[index]["name"],
                          list[index]["photo"], list[index]["nickname"]);
                    });
              }
            }),
      );

  Card contactCard(String name, String photo, String nickname) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(5),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(name),
            subtitle: Text(nickname),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(photo),
            ),
          ),
        ],
      ),
    );
  }
}
