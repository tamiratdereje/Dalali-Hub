import 'package:dio/dio.dart';
import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:injectable/injectable.dart';

@injectable
class JwtInterceptor extends Interceptor {
  final SharedPreference pref;
  JwtInterceptor({required this.pref});
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var token =  pref.getString(tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
