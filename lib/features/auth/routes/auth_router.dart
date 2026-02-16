import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_routes.dart';
import '../../../app/state/app_user_cubit/app_user_cubit.dart';
import '../../../core/router/app_feature_router.dart';
import '../presentation/pages/sign_in_page.dart';
import '../presentation/pages/signup_page.dart';
import 'auth_routes.dart';

class AuthRouter implements AppFeatureRouter {
  AuthRouter(this._appUserCubit);

  final AppUserCubit _appUserCubit;
  @override
  List<GoRoute> get routes => [
    GoRoute(
      path: AuthRoutes.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AuthRoutes.signUp,
      builder: (context, state) => const SignupPage(),
    ),
  ];

  static const guestOnlyRoutes = [AuthRoutes.signIn, AuthRoutes.signUp];

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final location = state.uri.path;
    final isLoggedIn = _appUserCubit.isLoggedIn;
    final isGuestOnlyRoute = guestOnlyRoutes.contains(location);

    if (!isLoggedIn && !isGuestOnlyRoute) {
      return AuthRoutes.signIn;
    }

    if (isLoggedIn && isGuestOnlyRoute) {
      return AppRoutes.home;
    }

    return null;
  }
}
