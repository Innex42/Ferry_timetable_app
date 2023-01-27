import 'package:flutter/material.dart';
import 'package:ferry_app/widgets/listitemwidget.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Search result'),
        ),
        body: customListView(context),
      );
}
