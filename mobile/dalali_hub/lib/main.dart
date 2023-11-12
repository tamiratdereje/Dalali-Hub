import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart';
import 'package:dalali_hub/app/navigation/navigator.dart';
import 'package:dalali_hub/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()..add(const AuthEvent.updateAuthStatus())),
          BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        ],
        child: Builder(
          builder: (context) => MaterialApp.router(
            title: 'dalali_hub',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: getIt<AppRouter>().router,
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
