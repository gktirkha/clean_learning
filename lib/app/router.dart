import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/common/cubits/app_user_cubit/app_user_cubit.dart';
import '../features/auth/presentation/pages/sign_in_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
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
        path: SignInPage.route,
        name: 'signIn',
        builder: (context, state) => const SignInPage(),
      ),

      GoRoute(
        path: SignupPage.route,
        name: 'signUp',
        builder: (context, state) => const SignupPage(),
      ),
    ],

    redirect: (context, state) {
      final isLoggedIn = appUserCubit.state is UserLoggedIn;

      final isAuthRoute =
          state.matchedLocation == SignInPage.route ||
          state.matchedLocation == SignupPage.route;

      if (!isLoggedIn && !isAuthRoute) {
        return SignInPage.route;
      }

      if (isLoggedIn && isAuthRoute) {
        return '/';
      }

      return null;
    },
  );
}
