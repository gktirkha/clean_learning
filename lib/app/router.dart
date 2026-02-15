import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/common/cubits/app_user_cubit/app_user_cubit.dart';
import '../features/auth/presentation/pages/sign_in_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import 'app_routes.dart';
import 'router_refresh.dart';

class AppRouter {
  AppRouter(this.appUserCubit);
  final AppUserCubit appUserCubit;

  late final GoRouter router = GoRouter(
    initialLocation: '/',

    refreshListenable: GoRouterRefreshStream(appUserCubit.stream),

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home'))),
      ),

      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInPage(),
      ),

      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignupPage(),
      ),
    ],

    redirect: (context, state) {
      final isLoggedIn = appUserCubit.state is UserLoggedIn;

      final isAuthRoute =
          state.matchedLocation == AppRoutes.signIn ||
          state.matchedLocation == AppRoutes.signUp;

      if (!isLoggedIn && !isAuthRoute) {
        return AppRoutes.signIn;
      }

      if (isLoggedIn && isAuthRoute) {
        return '/';
      }

      return null;
    },
  );
}
