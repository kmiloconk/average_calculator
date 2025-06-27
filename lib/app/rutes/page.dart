import 'package:average_calculator/app/fp/fp_page.dart';
import 'package:average_calculator/app/rutes/rutes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {Routes.Home: (_) => const HomePage()};
}
