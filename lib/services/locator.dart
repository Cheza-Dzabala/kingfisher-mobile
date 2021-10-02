import 'package:get_it/get_it.dart';
import 'package:kingfisher/notifiers/user_notifier.dart';
import 'package:kingfisher/services/authentication_service.dart';
import 'package:kingfisher/services/profile_service.dart';

GetIt getIt = GetIt.instance;

setUpServiceLocator() {
  getIt.registerLazySingleton<UserNotifier>(() => UserNotifier());

  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());

  getIt.registerLazySingleton<ProfileService>(() => ProfileService());
}
