import 'dart:convert';

import 'package:adguard_home_manager/constants/enums.dart';

final List<HomeTopItems> homeTopItemsDefaultOrder = [
  HomeTopItems.queriedDomains,
  HomeTopItems.blockedDomains,
  HomeTopItems.recurrentClients
];  

final String homeTopItemsDefaultOrderString = jsonEncode(
  List<String>.from(homeTopItemsDefaultOrder.map((e) => e.name))
);