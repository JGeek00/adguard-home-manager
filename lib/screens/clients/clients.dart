import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';
import 'package:adguard_home_manager/widgets/add_device_modal.dart';

class Clients extends StatelessWidget {
  const Clients({super.key});

  @override
  Widget build(BuildContext context) {
    final privateDnsProvider = Provider.of<PrivateDnsProvider>(context);
    final devices = privateDnsProvider.devices;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dispositivos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => privateDnsProvider.fetchDevices(),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddDeviceModal(),
              );
            },
          ),
        ],
      ),
      body: privateDnsProvider.loadingDevices
          ? const Center(child: CircularProgressIndicator())
          : devices.isEmpty
              ? const Center(child: Text("No hay dispositivos"))
              : ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return ListTile(
                      leading: const Icon(Icons.devices),
                      title: Text(device.name),
                      subtitle: Text("ID: ${device.id}\nType: ${device.deviceType}"),
                      isThreeLine: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddDeviceModal(device: device),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Eliminar Dispositivo'),
                              content: const Text('¿Estás seguro de que quieres eliminar este dispositivo?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await privateDnsProvider.deleteDevice(device.id);
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
