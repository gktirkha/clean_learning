import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'auth_injectable.config.dart';

@InjectableInit(
  preferRelativeImports: true,
  generateForDir: ['lib/features/auth'],
)
void configureAuthFeatureDependencies(GetIt diContainer) {
  diContainer.init();
}
