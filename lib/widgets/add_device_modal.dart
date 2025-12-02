import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';
import 'package:adguard_home_manager/models/adguard_dns/device.dart';

class AddDeviceModal extends StatefulWidget {
  final Device? device;

  const AddDeviceModal({super.key, this.device});

  @override
  State<AddDeviceModal> createState() => _AddDeviceModalState();
}

class _AddDeviceModalState extends State<AddDeviceModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedDeviceType = 'UNKNOWN';
  String? _selectedDnsServerId;
  bool _isProcessing = false;

  final List<String> _deviceTypes = [
    'WINDOWS', 'ANDROID', 'MAC', 'IOS', 'LINUX', 'ROUTER', 'SMART_TV', 'GAME_CONSOLE', 'UNKNOWN'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.device != null) {
      _nameController.text = widget.device!.name;
      _selectedDeviceType = widget.device!.deviceType;
      _selectedDnsServerId = widget.device!.dnsServerId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrivateDnsProvider>(context);

    // Set default server ID if not set
    if (_selectedDnsServerId == null && provider.dnsServers.isNotEmpty) {
      _selectedDnsServerId = provider.dnsServers.first.id;
    }

    return AlertDialog(
      title: Text(widget.device == null ? 'Agregar Dispositivo' : 'Editar Dispositivo'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDeviceType,
                decoration: const InputDecoration(labelText: 'Tipo de Dispositivo'),
                items: _deviceTypes.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                )).toList(),
                onChanged: (value) => setState(() => _selectedDeviceType = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDnsServerId,
                decoration: const InputDecoration(labelText: 'Servidor DNS (Perfil)'),
                items: provider.dnsServers.map((server) => DropdownMenuItem(
                  value: server.id,
                  child: Text(server.name),
                )).toList(),
                onChanged: (value) => setState(() => _selectedDnsServerId = value),
                validator: (value) => value == null ? 'Selecciona un perfil' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _isProcessing ? null : () async {
            if (_formKey.currentState!.validate()) {
              setState(() => _isProcessing = true);

              final data = {
                'name': _nameController.text,
                'device_type': _selectedDeviceType,
                'dns_server_id': _selectedDnsServerId,
              };

              bool success;
              if (widget.device == null) {
                success = await provider.createDevice(data);
              } else {
                success = await provider.updateDevice(widget.device!.id, data);
              }

              if (mounted) {
                setState(() => _isProcessing = false);
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error al guardar el dispositivo')),
                  );
                }
              }
            }
          },
          child: Text(widget.device == null ? 'Crear' : 'Guardar'),
        ),
      ],
    );
  }
}
