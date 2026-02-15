import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}
