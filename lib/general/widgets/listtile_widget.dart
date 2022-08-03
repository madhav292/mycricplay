import 'dart:core';

import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  String title;
  String subtitle;
  String imageUrl;
  ListTileWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.imageUrl = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}

Widget buildItems(dataList) => ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: dataList.length,
    separatorBuilder: (BuildContext context, int index) => const Divider(),
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(
          dataList[index]["Name"],
        ),
        subtitle: Text(dataList[index]["Dept"]),
        trailing: Text(
          dataList[index]["RollNo"],
        ),
      );
    });
