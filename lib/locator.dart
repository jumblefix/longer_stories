import 'package:get_it/get_it.dart';
import 'package:longer_stories/services/DialogService.dart';
import 'package:longer_stories/services/NavigationService.dart';
import 'package:longer_stories/services/StorageService.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => DialogService());
}
