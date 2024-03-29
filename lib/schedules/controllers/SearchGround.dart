import 'package:flutter/material.dart';
import 'package:mycricplay/grounds/grounds_model.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (query.isEmpty) {
          close(context, '');
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchList = _words
        .where((word) => word.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchList[index]),
          onTap: () {
            close(context, searchList[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _words.clear();
   

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

          return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: groundsModelList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                _words.add(groundsModelList[index].groundName);
                return ListTile(
                  onTap: () {
                    close(context, groundsModelList[index].groundName);
                  },
                  title: Text(groundsModelList[index].groundName),
                  subtitle: Text(groundsModelList[index].address),
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
