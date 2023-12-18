import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INetworkConfig)
class NetworkConfig implements INetworkConfig {
  final SharedPreference _sharedPreference;
  NetworkConfig(this._sharedPreference);
  @override
  String get baseUrl => 'https://cdf4-197-156-107-200.ngrok-free.app/';

  @override
  Duration get timeout => const Duration(seconds: 10);

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
        'authorization': "Bearer ${_sharedPreference.getString(tokenKey) ?? ''}",
      };
}
