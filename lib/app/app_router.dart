import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/router/app_feature_router.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/routes/auth_router.dart';
import 'app_routes.dart';
import 'router_refresh.dart';
import 'state/app_user_cubit/app_user_cubit.dart';

class AppRouter {
  AppRouter(this.appUserCubit) : _featureRouters = [AuthRouter(appUserCubit)];

  final AppUserCubit appUserCubit;

  final List<AppFeatureRouter> _featureRouters;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,

    refreshListenable: GoRouterRefreshStream(appUserCubit.stream),

    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Logged In'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEvent.signOut());
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),

      ..._featureRouters.expand((r) => r.routes),
    ],

    redirect: _handleRedirect,
  );

  String? _handleRedirect(BuildContext context, GoRouterState state) {
    for (final router in _featureRouters) {
      final result = router.redirect(context, state);
      if (result != null) return result;
    }
    return null;
  }
}
