import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_redirect.dart';

class RedirectManager {
  RedirectManager(this._redirects);

  final List<AppRedirect> _redirects;

  String? handle(BuildContext context, GoRouterState state) {
    for (final redirect in _redirects) {
      final result = redirect(context, state);
      if (result != null) return result;
    }
    return null;
  }
}
