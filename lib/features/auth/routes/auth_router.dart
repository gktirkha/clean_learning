import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_routes.dart';
import '../../../app/state/app_user_cubit/app_user_cubit.dart';
import '../presentation/pages/sign_in_page.dart';
import '../presentation/pages/signup_page.dart';
import 'auth_routes.dart';

class AuthRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: AuthRoutes.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AuthRoutes.signUp,
      builder: (context, state) => const SignupPage(),
    ),
  ];

  static final List<String> _authRoutes = [
    AuthRoutes.signIn,
    AuthRoutes.signUp,
  ];

  static String? redirect({
    required AppUserCubit appUserCubit,
    required BuildContext context,
    required GoRouterState state,
  }) {
    final location = state.uri.path;
    final isLoggedIn = appUserCubit.isLoggedIn;
    final isAuthRoute = _authRoutes.contains(location);

    if (!isLoggedIn && !isAuthRoute) {
      return AuthRoutes.signIn;
    }

    if (isLoggedIn && isAuthRoute) {
      return AppRoutes.home;
    }

    return null;
  }
}
