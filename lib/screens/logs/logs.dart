import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';
import 'package:adguard_home_manager/models/adguard_dns/query_log.dart';

class Logs extends StatefulWidget {
  const Logs({super.key});

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PrivateDnsProvider>(context, listen: false).fetchQueryLog();
    });
  }

  @override
  Widget build(BuildContext context) {
    final privateDnsProvider = Provider.of<PrivateDnsProvider>(context);
    final logs = privateDnsProvider.queryLog;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registros de Consultas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => privateDnsProvider.fetchQueryLog(),
          ),
        ],
      ),
      body: privateDnsProvider.loadingQueryLog
          ? const Center(child: CircularProgressIndicator())
          : logs == null || logs.items.isEmpty
              ? const Center(child: Text("No hay registros"))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: logs.items.length,
                  itemBuilder: (context, index) {
                    final item = logs.items[index];
                    return LogTile(item: item);
                  },
                ),
    );
  }
}

class LogTile extends StatelessWidget {
  final QueryLogItem item;

  const LogTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final status = item.filteringInfo?.filteringStatus ?? 'UNKNOWN';
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.help_outline;

    if (status == 'REQUEST_ALLOWED' || status == 'RESPONSE_ALLOWED') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (status == 'REQUEST_BLOCKED' || status == 'RESPONSE_BLOCKED') {
      statusColor = Colors.red;
      statusIcon = Icons.block;
    } else if (status == 'MODIFIED') {
      statusColor = Colors.orange;
      statusIcon = Icons.edit;
    }

    return ListTile(
      leading: Icon(statusIcon, color: statusColor),
      title: Text(item.domain),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(item.timeIso).toLocal())),
          if (item.deviceName != null) Text("Device: ${item.deviceName}"), // Assuming deviceName exists or we use deviceId
          if (item.filteringInfo?.filterRule != null) Text("Rule: ${item.filteringInfo!.filterRule}", style: const TextStyle(fontSize: 12)),
        ],
      ),
      isThreeLine: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(item.domain),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Status: $status"),
                  Text("Time: ${item.timeIso}"),
                  Text("Type: ${item.dnsRequestType ?? 'N/A'}"),
                  Text("Class: ${item.dnsResponseType ?? 'N/A'}"),
                  Text("Client Country: ${item.clientCountry ?? 'N/A'}"),
                  if (item.deviceId != null) Text("Device ID: ${item.deviceId}"),
                  if (item.filteringInfo?.filterId != null) Text("Filter List ID: ${item.filteringInfo?.filterId}"),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cerrar")),
            ],
          ),
        );
      },
    );
  }
}

extension QueryLogItemExt on QueryLogItem {
  String? get deviceName {
    // Helper to look up device name from provider if accessible,
    // but here we are in a widget, we can access provider if we pass it or context.
    // For simplicity, just return deviceId.
    return deviceId;
  }
}
