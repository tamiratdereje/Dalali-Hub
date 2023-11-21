
abstract class INetworkConfig {
  String get baseUrl;
  Map<String, String> get headers;
  Duration get timeout;
}