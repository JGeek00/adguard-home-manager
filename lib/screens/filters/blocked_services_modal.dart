import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/constants/services.dart';

class BlockedServicesModal extends StatefulWidget {
  final ScrollController scrollController;
  final List<String> blockedServices;
  final void Function(List<String>) onApply;
    
  const BlockedServicesModal({
    Key? key,
    required this.scrollController,
    required this.blockedServices,
    required this.onApply,
  }) : super(key: key);

  @override
  State<BlockedServicesModal> createState() => _BlockedServicesModalState();
}

class _BlockedServicesModalState extends State<BlockedServicesModal> {
  List<Map<String, dynamic>> values = [];

  List<String> convertFinalValues() {
    return List<String>.from(
      values.map((v) => v['checked'] == true ? v['id'] : '').where((v) => v != '')
    );
  }

  void updateValues(bool value, Map<String, dynamic> item) {
    setState(() => values = values.map((v) {
      if (v['id'] == item['id']) {
        return {
          'id': v['id'],
          'checked': value
        };
      }
      else {
        return v;
      }
    }).toList());
  }

  @override
  void initState() {
    for (var service in services) {
      values.add({
        "id": service['id'],
        "checked": widget.blockedServices.contains(service['id'])
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = convertFinalValues().length == services.length ? true : false;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28)
        )
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 28),
                  child: Icon(
                    Icons.block,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.blockedServices,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: services.length,
                  itemBuilder: (context, index) => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => updateValues(!(values[index]['checked'] as bool), services[index]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              services[index]['label']!,
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            ),
                            Checkbox(
                              value: values[index]['checked'], 
                              onChanged: (value) => updateValues(value!, services[index]),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => {
                    allSelected == true
                      ? setState(() => values = values.map((v) => {
                          'id': v['id'],
                          'checked': false
                        }).toList())
                      : setState(() => values = values.map((v) => {
                          'id': v['id'],
                          'checked': true
                        }).toList())
                  }, 
                  child: Text(
                    allSelected == true
                      ? AppLocalizations.of(context)!.unselectAll
                      : AppLocalizations.of(context)!.selectAll
                  )
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: Text(AppLocalizations.of(context)!.cancel)
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onApply(convertFinalValues());
                      }, 
                      child: Text(AppLocalizations.of(context)!.apply)
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}