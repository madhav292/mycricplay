import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycricplay/general/widgets/roundedtextfield_widget.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
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
              title: Text('Grounds'),
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
  }
}
