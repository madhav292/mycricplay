import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/instance_manager.dart';
import 'package:mycricplay/general/widgets/listtile_widget.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:provider/provider.dart';

import '../general/ScreenLoading/loading_screen.dart';
import 'groundlistdetails_screen.dart';

class GroundsList extends StatefulWidget {
  const GroundsList({Key? key}) : super(key: key);

  @override
  State<GroundsList> createState() => _GroundsListState();
}

class _GroundsListState extends State<GroundsList> {
  List<Widget> groundList = [];

  @override
  Widget build(BuildContext context) {
    List<GroundsModel> groundsModelList;
    return FutureBuilder(
      future: GroundsModel.GroundsModelObj().getGroundsList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            "Something went wrong",
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          groundsModelList = snapshot.data as List<GroundsModel>;
          return MaterialApp(
              home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
            body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: groundsModelList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Get.put(groundsModelList[index]);
                      Get.to(
                          GroundDetailsForm(modelObj: groundsModelList[index]));
                    },
                    title: Text(groundsModelList[index].groundName),
                    subtitle: Text(groundsModelList[index].address),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(groundsModelList[index].imageUrl)),
                  );
                }),
          ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
    /* return StreamBuilder<QuerySnapshot>(

        stream: GroundsModel.readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading_Screen();
          }

          return MaterialApp(
              home: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Get.to(GroundDetailsForm());
                    },
                    child: const Icon(Icons.add),
                  ),
                  appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text('Ground List')),
                  body: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    GroundsModel grounds_modelObj =
                        Get.put(GroundsModel.fromJson(data));

                    return Dismissible(
                      key: Key(grounds_modelObj.groundName),
                      onDismissed: (direction) {
                        GroundsModel.deleteData(grounds_modelObj);
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Deleted')));
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      // Remove the item from the data source.

                      child: ListTile(
                        onTap: () {
                          snapshot.datad
                          Get.to(GroundDetailsForm());
                        },
                        title: Text(data['groundName']),
                        subtitle: Text(data['address']),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  }).toList())));
        });*/
  }
}
