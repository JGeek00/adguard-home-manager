import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';
import 'package:adguard_home_manager/providers/private_dns_provider.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/add_dns_server_modal.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PrivateDnsProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final privateDnsProvider = Provider.of<PrivateDnsProvider>(context);
    final limits = privateDnsProvider.accountLimits;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => privateDnsProvider.fetchData(),
          ),
        ],
      ),
      body: privateDnsProvider.loadingAccountLimits
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => await privateDnsProvider.fetchData(),
              child: ListView(
                children: [
                  if (limits != null) ...[
                    SectionLabel(
                      label: "Límites de la cuenta", // TODO: Localize
                      padding: const EdgeInsets.all(16),
                    ),
                    _buildLimitTile("Dispositivos", limits.devices.used, limits.devices.limit),
                    _buildLimitTile("Servidores DNS", limits.dnsServers.used, limits.dnsServers.limit),
                    _buildLimitTile("Reglas de acceso", limits.accessRules.used, limits.accessRules.limit),
                    _buildLimitTile("Reglas de usuario", limits.userRules.used, limits.userRules.limit),
                    _buildLimitTile("Peticiones", limits.requests.used, limits.requests.limit),
                  ],

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.servers,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AddDnsServerModal(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (privateDnsProvider.dnsServers.isEmpty)
                     const Padding(
                       padding: EdgeInsets.all(16.0),
                       child: Text("No hay servidores DNS"),
                     )
                  else
                    ...privateDnsProvider.dnsServers.map((s) => ListTile(
                      title: Text(s.name),
                      subtitle: Text(s.id),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (s.isDefault) const Icon(Icons.star, color: Colors.amber),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text("Editar"),
                              ),
                              if (!s.isDefault) const PopupMenuItem(
                                value: 'delete',
                                child: Text("Eliminar"),
                              ),
                            ],
                            onSelected: (value) async {
                              if (value == 'edit') {
                                showDialog(
                                  context: context,
                                  builder: (context) => AddDnsServerModal(dnsServer: s),
                                );
                              } else if (value == 'delete') {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Eliminar Perfil'),
                                    content: const Text('¿Estás seguro de que quieres eliminar este perfil?'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  await privateDnsProvider.deleteDnsServer(s.id);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    )),

                  SectionLabel(
                    label: "Dispositivos",
                    padding: const EdgeInsets.all(16),
                  ),
                   if (privateDnsProvider.devices.isEmpty)
                     const Padding(
                       padding: EdgeInsets.all(16.0),
                       child: Text("No hay dispositivos"),
                     )
                  else
                    ...privateDnsProvider.devices.map((d) => ListTile(
                      title: Text(d.name),
                      subtitle: Text(d.id),
                    )),
                ],
              ),
            ),
    );
  }

  Widget _buildLimitTile(String title, int used, int limit) {
    return ListTile(
      title: Text(title),
      trailing: Text("$used / $limit"),
      subtitle: LinearProgressIndicator(
        value: limit > 0 ? used / limit : 0,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
