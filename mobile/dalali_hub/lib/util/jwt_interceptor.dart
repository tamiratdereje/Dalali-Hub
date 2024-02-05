import 'package:dio/dio.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:injectable/injectable.dart';

@injectable
class JwtInterceptor extends Interceptor {
  final SharedPreference pref;
  JwtInterceptor({required this.pref});
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var user =  pref.getUserAuthDetails();
    if (user != null) {
      options.headers['Authorization'] = 'Bearer ${user.token}';
    }
    super.onRequest(options, handler);
  }
}
