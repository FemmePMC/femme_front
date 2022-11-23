// ignore_for_file: must_be_immutable
import 'package:best_flutter_ui_templates/back/manager.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/pruebas/page/favourites_page.dart';
import 'package:best_flutter_ui_templates/pruebas/page/people_page.dart';
import 'package:best_flutter_ui_templates/pruebas/page/user_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:best_flutter_ui_templates/back/alerts.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  User userService = User("1", "0", "0");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 158, 112, 162),
        child: FutureBuilder<Map<String, dynamic>>(
          future: userService.getUser(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  buildHeader(
                    urlImage: snapshot.data!['photo'],
                    name: snapshot.data!['name'],
                    email: snapshot.data!['email'],
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                        name: snapshot.data!['name'],
                        urlImage: snapshot.data!['photo'],
                      ),
                    )),
                  ),
                  Container(
                    padding: padding,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Divider(color: Colors.white70),
                        const SizedBox(height: 24),
                        buildMenuItem(
                          text: 'Contactos',
                          icon: Icons.people,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Donar',
                          icon: Icons.favorite_sharp,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Calificanos',
                          icon: Icons.star,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Sobre Nosotros',
                          icon: Icons.info,
                          onClicked: launchLanding,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 40, backgroundImage: NetworkImage(urlImage)),
                  Text(
                    name,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer()
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PeoplePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritesPage(),
        ));
        break;
      case 3:
        launchLanding();
        break;
    }
  }

  launchLanding() async {
    Uri url = Uri.parse('https://cristian26aso.wixsite.com/femme');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch';
    }
  }
}
