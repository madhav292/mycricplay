import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words = [
    'apple',
    'banana',
    'cherry',
    'dates',
    'elderberry',
    'fig',
    'grape',
    'honeydew',
  ];

  final List<String> _history = [
    'apple',
    'banana',
    'cherry',
  ];

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
    final List<String> suggestionList = query.isEmpty
        ? _history
        : _words
        .where((word) => word.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}