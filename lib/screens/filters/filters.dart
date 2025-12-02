import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    final privateDnsProvider = Provider.of<PrivateDnsProvider>(context);
    final filterLists = privateDnsProvider.filterLists;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listas de Filtros"), // TODO: Localize
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => privateDnsProvider.fetchFilterLists(),
          ),
        ],
      ),
      body: privateDnsProvider.loadingFilterLists
          ? const Center(child: CircularProgressIndicator())
          : filterLists.isEmpty
              ? const Center(child: Text("No hay listas de filtros"))
              : ListView.builder(
                  itemCount: filterLists.length,
                  itemBuilder: (context, index) {
                    final filter = filterLists[index];
                    return ListTile(
                      title: Text(filter.name),
                      subtitle: Text("${filter.description}\nReglas: ${filter.rulesCount}"),
                      isThreeLine: true,
                    );
                  },
                ),
    );
  }
}
