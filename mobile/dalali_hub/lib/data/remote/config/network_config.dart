import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INetworkConfig)
class NetworkConfig implements INetworkConfig {
  @override
  String get baseUrl => 'https://d35c-196-190-62-166.ngrok-free.app/';

  @override
  Duration get timeout => const Duration(seconds: 10);

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
      };
}
