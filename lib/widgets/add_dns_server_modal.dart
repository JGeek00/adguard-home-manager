import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';
import 'package:adguard_home_manager/models/adguard_dns/dns_server.dart';

class AddDnsServerModal extends StatefulWidget {
  final DnsServer? dnsServer;

  const AddDnsServerModal({super.key, this.dnsServer});

  @override
  State<AddDnsServerModal> createState() => _AddDnsServerModalState();
}

class _AddDnsServerModalState extends State<AddDnsServerModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    if (widget.dnsServer != null) {
      _nameController.text = widget.dnsServer!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrivateDnsProvider>(context, listen: false);

    return AlertDialog(
      title: Text(widget.dnsServer == null ? 'Crear Perfil' : 'Editar Perfil'),
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
              };

              bool success;
              if (widget.dnsServer == null) {
                success = await provider.createDnsServer(data);
              } else {
                success = await provider.updateDnsServer(widget.dnsServer!.id, data);
              }

              if (mounted) {
                setState(() => _isProcessing = false);
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error al guardar el perfil')),
                  );
                }
              }
            }
          },
          child: Text(widget.dnsServer == null ? 'Crear' : 'Guardar'),
        ),
      ],
    );
  }
}
