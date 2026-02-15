import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/di/di_container.dart';
import '../core/di/init_dependencies.dart';
import '../core/secrets/app_secrets.dart';
import '../core/utils/bloc_observer.dart';
import '../features/auth/di/auth_injectable.dart';
import 'app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureCoreDependencies(diContainer);
  configureAuthFeatureDependencies(diContainer);

  Bloc.observer = AppBlocObserver();
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  runApp(const App());
}
