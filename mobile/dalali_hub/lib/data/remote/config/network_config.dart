import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INetworkConfig)
class NetworkConfig implements INetworkConfig {
  @override
  String get baseUrl => 'https://dalali-hub.onrender.com/';

  @override
  Duration get timeout => const Duration(seconds: 30);

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
      };
}
