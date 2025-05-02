import 'package:average_calculator/app/pv/pv_page.dart';
import 'package:average_calculator/app/rutes/rutes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {Routes.PV: (_) => const PvPage()};
}
