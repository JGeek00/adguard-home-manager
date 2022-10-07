import 'package:flutter/material.dart';

class CustomRulesList extends StatelessWidget {
  final List<String> data;

  const CustomRulesList({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (context, index) => ListTile(
        onLongPress: () => {},
        title: Text(data[index]),
        trailing: IconButton(
          onPressed: () => {}, 
          icon: const Icon(Icons.delete)
        ),
      )
    );
  }
}