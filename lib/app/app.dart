import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/di_container.dart';
import '../core/theme/theme.dart';
import '../core/utils/snack_bar_utils.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import 'app_router.dart';
import 'state/app_user_cubit/app_user_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appUserCubit = diContainer<AppUserCubit>();
    final appRouter = AppRouter(appUserCubit);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => diContainer<AuthBloc>()..add(const .checkLogin()),
        ),
        BlocProvider<AppUserCubit>.value(value: appUserCubit),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldKey,
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.router,
      ),
    );
  }
}
