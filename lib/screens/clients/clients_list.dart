import 'package:flutter/material.dart';

import 'package:adguard_home_manager/models/clients.dart';

class ClientsList extends StatelessWidget {
  final List<AutoClient> data;

  const ClientsList({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          data[index].name != '' 
            ? data[index].name!
            : data[index].ip
        ),
        subtitle: data[index].name != ''
          ? Text(
              data[index].ip
            )
          : null,
        trailing: Text(data[index].source),
      )
    );
  }
}