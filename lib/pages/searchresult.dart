import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

Widget _customListView(BuildContext context) {
  Widget customListViewItem = Expanded(
      child: Column(
    children: [
      Row(
        children: const [
          Text(
            "09:15",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.arrow_forward,
            size: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "09:35",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: const [
          Icon(
            Icons.warning,
            color: Colors.orange,
            size: 50,
          ),
          SizedBox(
            width: 30,
          ),
          Text('Duration: 20 Mins',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      )
    ],
  ));

  return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[customListViewItem]),
          ),
        );
      });
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Search result'),
        ),
        body: _customListView(context),
      );
}
