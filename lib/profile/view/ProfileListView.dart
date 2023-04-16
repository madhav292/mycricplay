import 'package:flutter/material.dart';
import 'package:mycricplay/profile/controller/ProfileController.dart';
import 'package:mycricplay/profile/model/ProfileModel.dart';

import '../../general/ScreenLoading/loading_screen.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreen();
}

class _UsersListScreen extends State<UsersListScreen> {
  ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProfileModel>>(
        future: profileController.getUsersList(),
        builder: (context, userListSnapshot) {
          if (userListSnapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (userListSnapshot.connectionState == ConnectionState.waiting) {
            return const Loading_Screen();
          }

          return MaterialApp(
              home: Scaffold(
                  appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text('Players')),
                  body: ListView.builder(
                      itemCount: userListSnapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        ProfileModel modelObj =
                            userListSnapshot.data![index];
                        return ListTile(
                          onTap: () {},
                          leading:  CircleAvatar(
                              backgroundImage: NetworkImage(modelObj.imageUrl)),
                          title: Text(
                              '${modelObj.firstName} ${modelObj.lastName}'),
                          subtitle: Text(modelObj.mobileNumber),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                        ;
                      })));
        });
  }

  @override
  void initState() {}
}
