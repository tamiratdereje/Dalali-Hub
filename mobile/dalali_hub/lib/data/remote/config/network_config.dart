import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INetworkConfig)
class NetworkConfig implements INetworkConfig {
  @override
  String get baseUrl => 'https://1f5c-196-191-61-250.ngrok-free.app/';

  @override
  Duration get timeout => const Duration(seconds: 10);

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
      };
}
