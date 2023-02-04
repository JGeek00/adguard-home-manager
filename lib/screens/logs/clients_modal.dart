import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/logs_provider.dart';

class ClientsModal extends StatefulWidget {
  final List<String>? value;

  const ClientsModal({
    Key? key,
    required this.value
  }) : super(key: key);

  @override
  State<ClientsModal> createState() => _ClientsModalState();
}

class _ClientsModalState extends State<ClientsModal> {
  List<String> selectedClients = [];

  @override
  void initState() {
    setState(() => selectedClients = widget.value ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    final height = MediaQuery.of(context).size.height;

    void apply() async {
      logsProvider.setSelectedClients(
        selectedClients.isNotEmpty ? selectedClients : null
      );

      Navigator.pop(context);
    }

    Widget listItem({
      required String label,
      required void Function() onChanged
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChanged(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                Checkbox(
                  value: selectedClients.contains(label), 
                  onChanged: (_) => onChanged(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    void selectAll() {
      setState(() {
        selectedClients = logsProvider.clients!.map((item) => item.ip).toList();
      });
    }

    void unselectAll() {
      setState(() {
        selectedClients = [];
      });
    }

    return Container(
      height: height >= (logsProvider.clients!.length*64) == true
        ? logsProvider.clients!.length*64
        : height-25,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28) 
        ),
        color: Theme.of(context).dialogBackgroundColor
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Icon(
              Icons.smartphone_rounded,
              size: 24,
              color: Theme.of(context).listTileTheme.iconColor
            ),
          ),
          Text(
            AppLocalizations.of(context)!.clients,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              physics: height >= (logsProvider.clients!.length*64) == true
                ? const NeverScrollableScrollPhysics()
                : null,
              itemCount: logsProvider.clients!.length,
              itemBuilder: (context, index) => listItem(
                label: logsProvider.clients![index].ip, 
                onChanged: () {
                  if (selectedClients.contains(logsProvider.clients![index].ip)) {
                    setState(() {
                      selectedClients = selectedClients.where(
                        (item) => item != logsProvider.clients![index].ip
                      ).toList();
                    });
                  }
                  else {
                    setState(() {
                      selectedClients.add(logsProvider.clients![index].ip);
                    });
                  }
                }
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: selectedClients.length == logsProvider.clients!.length
                    ? () => unselectAll()
                    : () => selectAll(), 
                  child: Text(
                    selectedClients.length == logsProvider.clients!.length
                      ? AppLocalizations.of(context)!.unselectAll
                      : AppLocalizations.of(context)!.selectAll
                  )
                ),
                TextButton(
                  onPressed: apply, 
                  child: Text(AppLocalizations.of(context)!.apply)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}