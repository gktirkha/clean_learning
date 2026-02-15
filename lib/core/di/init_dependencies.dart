import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secrets/app_secrets.dart';
import '../utils/bloc_observer.dart';
import 'init_dependencies.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit()
Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  serviceLocator.init();
}
