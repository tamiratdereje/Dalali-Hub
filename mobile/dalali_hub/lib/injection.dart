import 'package:get_it/get_it.dart';
import 'package:dalali_hub/injection.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();
