import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/state/app_user_cubit/app_user_cubit.dart';
import '../presentation/pages/sign_in_page.dart';
import '../presentation/pages/signup_page.dart';
import 'auth_routes.dart';

class AuthRouter {
  static const signIn = AuthRoutes.signIn;
  static const signUp = AuthRoutes.signUp;

  static List<GoRoute> get routes => [
    GoRoute(path: signIn, builder: (context, state) => const SignInPage()),
    GoRoute(path: signUp, builder: (context, state) => const SignupPage()),
  ];

  static String? redirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;

    final appUserCubit = context.read<AppUserCubit>();
    final isLoggedIn = appUserCubit.state is UserLoggedIn;

    final isAuthRoute = location == signIn || location == signUp;

    if (!isLoggedIn && !isAuthRoute) {
      return signIn;
    }

    if (isLoggedIn && isAuthRoute) {
      return '/';
    }

    return null;
  }
}
