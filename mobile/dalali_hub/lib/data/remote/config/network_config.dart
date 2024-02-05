import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INetworkConfig)
class NetworkConfig implements INetworkConfig {
  @override
  String get baseUrl => 'http://6562-196-190-60-209.ngrok-free.app/';

  @override
  Duration get timeout => const Duration(seconds: 10);

  @override
  Map<String, String> get headers => { 'accept': 'application/json' };


}
