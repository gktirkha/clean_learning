import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secrets/app_secrets.dart';
import '../utils/bloc_observer.dart';
import 'di_container.dart';
import 'init_dependencies.config.dart';

@InjectableInit(preferRelativeImports: true)
Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  diContainer.init();
}
