import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/clients/clients_lists.dart';

import 'package:adguard_home_manager/models/clients.dart';

final clientsNavigatorKey = GlobalKey<NavigatorState>();

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> with TickerProviderStateMixin {
  List<AutoClient> generateClientsList(List<AutoClient> clients, List<String> ips) {
    return clients.where((client) => ips.contains(client.ip)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
            children: [
              const Expanded(
                flex: 1,
                child: ClientsLists(
                  splitView: true,
                )
              ),
              Expanded(
                flex: 2,
                child: Navigator(
                  key: clientsNavigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(builder: (ctx) => const SizedBox()),
                ),
              )
            ],
          );
          }
          else {
            return const ClientsLists(
              splitView: false,
            );
          }
        },
      ),
    );
  }
}