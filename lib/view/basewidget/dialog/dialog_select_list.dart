import 'package:flutter/material.dart';

class DialogSelectList extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> listStringDynamic;
  final IndexedWidgetBuilder indexedWidgetBuilder;

  DialogSelectList({this.title = '', this.listStringDynamic = const [], @required this.indexedWidgetBuilder});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title
      ),
      content: Container(
        width: double.minPositive,
        child: Column(
          children: [
            // TODO :
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: this.listStringDynamic.length,
                itemBuilder: (context, index) => indexedWidgetBuilder(context, index),
              ),
            )
          ],
        ),
      ),
    );
  }
}
