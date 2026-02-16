import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/di_container.dart';
import '../core/router/app_feature_router.dart';
import '../core/theme/theme.dart';
import '../core/utils/snack_bar_utils.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/routes/auth_router.dart';
import 'app_router.dart';
import 'state/app_user_cubit/app_user_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppUserCubit _appUserCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _buildRouter();
  }

  void _buildRouter() {
    _appUserCubit = diContainer<AppUserCubit>();
    final featureRouters = <AppFeatureRouter>[AuthRouter(_appUserCubit)];
    _appRouter = AppRouter(
      appUserCubit: _appUserCubit,
      featureRouters: featureRouters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => diContainer<AuthBloc>()..add(const .checkLogin()),
        ),
        BlocProvider<AppUserCubit>.value(value: _appUserCubit),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldKey,
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
