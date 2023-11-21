import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INetworkConfig)
class NetworkConfig implements INetworkConfig {
  @override
  String get baseUrl => 'http://192.168.176.1:3000/';

  @override
  Duration get timeout => const Duration(seconds: 30);

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
      };
}
