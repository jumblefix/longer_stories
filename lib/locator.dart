import 'package:get_it/get_it.dart';
import 'package:longer_stories/services/NavigationService.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
}
