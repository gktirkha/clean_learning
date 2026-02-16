import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class AppFeatureRouter {
  List<GoRoute> get routes;

  String? redirect(BuildContext context, GoRouterState state);
}
