import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_radio_list_tile.dart';

class DnsModeModal extends StatefulWidget {
  final String upstreamMode;
  final void Function(String) onConfirm;

  const DnsModeModal({
    Key? key,
    required this.upstreamMode,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<DnsModeModal> createState() => _DnsModeModalState();
}

class _DnsModeModalState extends State<DnsModeModal> {
  String upstreamMode = "";

  @override
  void initState() {
    upstreamMode = widget.upstreamMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 660,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28)
        )
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 28, bottom: 20),
            child: Icon(
              Icons.dns_rounded,
              size: 26,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.dnsMode,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24
            ),
          ),
          const SizedBox(height: 10),
          CustomRadioListTile(
            groupValue: upstreamMode, 
            value: "load_balancing", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.loadBalancing,
            subtitle: AppLocalizations.of(context)!.loadBalancingDescription,
            onChanged: (value) => setState(() => upstreamMode = value),
          ),
          CustomRadioListTile(
            groupValue: upstreamMode, 
            value: "parallel_requests", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.parallelRequests,
            subtitle: AppLocalizations.of(context)!.parallelRequestsDescription,
            onChanged: (value) => setState(() => upstreamMode = value),
          ),
          CustomRadioListTile(
            groupValue: upstreamMode, 
            value: "fastest_ip_address", 
            radioBackgroundColor: Theme.of(context).dialogBackgroundColor, 
            title: AppLocalizations.of(context)!.fastestIpAddress,
            subtitle: AppLocalizations.of(context)!.fastestIpAddressDescription,
            onChanged: (value) => setState(() => upstreamMode = value),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20, 
              right: 20
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(AppLocalizations.of(context)!.close)
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onConfirm(upstreamMode);
                  }, 
                  child: Text(AppLocalizations.of(context)!.confirm)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}