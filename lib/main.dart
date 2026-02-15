import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/state/app_user_cubit/app_user_cubit.dart';
import 'core/di/di_container.dart';
import 'core/di/init_dependencies.dart';
import 'core/theme/theme.dart';
import 'core/utils/snack_bar_utils.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';

void main() async {
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => diContainer<AuthBloc>()),
        BlocProvider(create: (context) => diContainer<AppUserCubit>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const .isLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      theme: AppTheme.darkTheme,
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is UserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return Scaffold(
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
            );
          }
          return const SignInPage();
        },
      ),
    );
  }
}
