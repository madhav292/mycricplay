import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/general/ImagePickerExample.dart';
import 'package:mycricplay/general/ImageUploads.dart';
import 'package:mycricplay/grounds/groundslist_screen.dart';
import 'package:mycricplay/profile/model/ProfileModel.dart';
import 'package:mycricplay/schedules/view/schedulelist_screen.dart';
import 'package:mycricplay/teams/teamslist_screen.dart';
import 'package:mycricplay/profile/view/ProfileListView.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      const Center(
        child: Text('Welcome'),
      ),
      const Icon(
        Icons.camera,
        size: 150,
      ),
      const Icon(
        Icons.chat,
        size: 150,
      ),
    ];
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Madhava Reddy'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed((context), '/profile_screen');
              },
            ),
            ListTile(
              title: const Text('Schedules'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScheduleList()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Grounds'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroundsList()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Teams'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeamsListScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Players'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UsersListScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Image picker'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageUploads()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Image picker2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImagePickerExample()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body:
          const Center(child: ScheduleList() //_pages.elementAt(_selectedIndex),
              ),
      appBar: AppBar(
        title: const Text('Stockholm Titans'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'My Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Club info',
          ),
        ],
      ),
    );
  }
}
