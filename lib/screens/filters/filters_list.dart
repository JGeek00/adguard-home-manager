import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class FiltersList extends StatelessWidget {
  final List<Filter> data;

  const FiltersList({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (context, index) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width-130,
                      child: Text(
                        data[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${intFormat(data[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
                Text(
                  data[index].enabled == true
                    ? AppLocalizations.of(context)!.enabled
                    : AppLocalizations.of(context)!.disabled,
                  style: TextStyle(
                    color: data[index].enabled == true
                      ? Colors.green
                      : Colors.red,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}