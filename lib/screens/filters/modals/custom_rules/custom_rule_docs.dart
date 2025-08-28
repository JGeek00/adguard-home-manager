import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/functions/open_url.dart';

class CustomRuleDocs extends StatelessWidget {
  const CustomRuleDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                      const SizedBox(width: 20),
                      Text(
                        AppLocalizations.of(context)!.examples,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "||example.org^",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example1,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "@@||example.org^",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example2,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "! Here goes a comment",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        Text(
                          "# Also a comment",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example3,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "/REGEX/",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.example4,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => openUrl(Urls.customRuleDocs),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      AppLocalizations.of(context)!.moreInformation,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.open_in_new,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}