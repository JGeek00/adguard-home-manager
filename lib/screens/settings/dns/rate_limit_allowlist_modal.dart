import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _IpListItemController {
  final String id;
  final TextEditingController controller;
  bool error;

  _IpListItemController({
    required this.id,
    required this.controller,
    required this.error
  });
}

class RateLimitAllowlistModal extends StatefulWidget {
  final List<String> values;
  final void Function(List<String>) onConfirm;

  const RateLimitAllowlistModal({
    super.key,
    required this.values,
    required this.onConfirm,
  });

  @override
  State<RateLimitAllowlistModal> createState() => _RateLimitAllowlistModalState();
}

class _RateLimitAllowlistModalState extends State<RateLimitAllowlistModal> {
  final Uuid uuid = const Uuid();
  List<_IpListItemController> _controllersList = [];

  void _validateIp(String value, _IpListItemController item) {
    final regexp = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$');
    if (regexp.hasMatch(value)) {
      setState(() => _controllersList = _controllersList.map((e) {
        if (e.id == item.id) {
          return _IpListItemController(
            id: e.id, 
            controller: e.controller, 
            error: false
          );
        }
        return e;
      }).toList());
    }
    else {
      setState(() => _controllersList = _controllersList.map((e) {
        if (e.id == item.id) {
          return _IpListItemController(
            id: e.id, 
            controller: e.controller, 
            error: true
          );
        }
        return e;
      }).toList());
    }
  }

  @override
  void initState() {
    _controllersList = widget.values.map((e) => _IpListItemController(
      id: uuid.v4(), 
      controller: TextEditingController(text: e), 
      error: false
    )).toList();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final validData = _controllersList.where((e) => e.error == true).isEmpty;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.rateLimitAllowlist,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._controllersList.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: item.controller,
                                onChanged: (v) => _validateIp(v, item),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.link_rounded),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10)
                                    )
                                  ),
                                  labelText: AppLocalizations.of(context)!.ipAddress,
                                  errorText: item.error == true
                                    ? AppLocalizations.of(context)!.invalidIp
                                    : null
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () => setState(
                                () => _controllersList = _controllersList.where((c) => c.id != item.id).toList()
                              ), 
                              icon: const Icon(Icons.remove_circle_outline_rounded),
                              tooltip: AppLocalizations.of(context)!.remove,
                            )
                          ],
                        ),
                      )),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() => _controllersList.add(
                            _IpListItemController(
                              id: uuid.v4(), 
                              controller: TextEditingController(),
                              error: false
                            ),
                          )),
                          icon: const Icon(Icons.add_rounded),
                          label: Text(AppLocalizations.of(context)!.addItem),
                        ),
                      )
                    ],
                  ),
                )
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text(AppLocalizations.of(context)!.cancel)
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: validData == true
                      ? () {
                          widget.onConfirm(
                            _controllersList.map((e) => e.controller.text).toList()
                          );
                          Navigator.pop(context);
                        }
                      : null, 
                    child: Text(AppLocalizations.of(context)!.confirm)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}