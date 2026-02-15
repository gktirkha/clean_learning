import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/router/redirect_manager.dart';
import '../features/auth/routes/auth_router.dart';
import 'app_routes.dart';
import 'router_refresh.dart';
import 'state/app_user_cubit/app_user_cubit.dart';

class AppRouter {
  AppRouter(this.appUserCubit);

  final AppUserCubit appUserCubit;

  late final RedirectManager _redirectManager = RedirectManager([
    AuthRouter.redirect,
  ]);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,

    refreshListenable: GoRouterRefreshStream(appUserCubit.stream),

    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home'))),
      ),
      ...AuthRouter.routes,
    ],

    redirect: (context, state) => _redirectManager.handle(context, state),
  );
}
