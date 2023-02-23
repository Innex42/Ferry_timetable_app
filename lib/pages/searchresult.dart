//import 'package:ferry_app/models/routemodel.dart';
//import 'package:ferry_app/services/route_api_service.dart';
import 'package:ferry_app/models/ferrytimesmodel.dart';
import 'package:ferry_app/services/ferry_times_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ferry_app/widgets/listitemwidget.dart';
import 'dart:convert';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late List<FerryTimes>? ferryTimes = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    ferryTimes = await FerryTimesApiService().getFerryTimes();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Search result'),
      ),
      body: ferryTimes == null || ferryTimes!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: ferryTimes!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(ferryTimes![index].departureTime),
                        Text(ferryTimes![index].arrivalTime),
                        Text(ferryTimes![index].duration)
                      ],
                    )
                  ]),
                );
              },
            )
      //customListView(context),
      );
}
