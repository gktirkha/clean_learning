import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/router/redirect_manager.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/routes/auth_router.dart';
import 'app_routes.dart';
import 'router_refresh.dart';
import 'state/app_user_cubit/app_user_cubit.dart';

class AppRouter {
  AppRouter(this.appUserCubit);

  final AppUserCubit appUserCubit;

  late final RedirectManager _redirectManager = RedirectManager([
    (context, state) => AuthRouter.redirect(
      appUserCubit: appUserCubit,
      state: state,
      context: context,
    ),
  ]);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,

    refreshListenable: GoRouterRefreshStream(appUserCubit.stream),

    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                const Text('Logged In'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const .signOut());
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
      ...AuthRouter.routes,
    ],

    redirect: (context, state) => _redirectManager.handle(context, state),
  );
}
