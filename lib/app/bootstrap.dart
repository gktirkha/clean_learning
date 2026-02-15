import 'package:flutter/widgets.dart';

import '../core/di/init_dependencies.dart';
import 'app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const App());
}
