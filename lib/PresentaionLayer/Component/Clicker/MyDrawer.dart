import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/PresentaionLayer/Component/Clicker/MyTile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),

// home tile

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: MyTile(
                  text: 'H O M E',
                  icons: Icon(Icons.home),
                  onTap: () {
                    Navigator.pushNamed(context, 'Home');
                  },
                ),
              ),

// profile title

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: MyTile(
                  text: 'P R O F I L E',
                  icons: Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, 'Profile');
                  },
                ),
              ),
// Useres tile
            ],
          ),
//Log out tile
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 15),
            child: MyTile(
              text: 'LOG OUT',
              icons: Icon(Icons.logout),
              onTap: () {
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
