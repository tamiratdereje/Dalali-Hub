import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:dalali_hub/app/core/widgets/dismiss_widgets.dart';
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart';
import 'package:dalali_hub/app/pages/chat/bloc/get_rooms/get_rooms_bloc.dart';
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart';
import 'package:dalali_hub/app/pages/favorite/bloc/get_my_favorites/get_my_favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalali_hub/app/navigation/navigator.dart';
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart';
import 'package:dalali_hub/injection.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.updateAuthStatus()),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => getIt<LogoutBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt.get<FeedsBloc>()..add(const FeedsEvent.feeds()),
        ),
        BlocProvider(
          create: (context) => getIt.get<GetMyFavoritesBloc>()
            ..add(const GetMyFavoritesEvent.getMyFavorites()),
        ),
        BlocProvider(
          create: (context) => getIt.get<GetMyFavoritesBloc>()
            ..add(const GetMyFavoritesEvent.getMyFavorites()),
        ),
        BlocProvider(
          create: (context) => getIt.get<GetRoomsBloc>(),
        )
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Property Management',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: SafeArea(
              child: DismissKeyboard(
                child: ResponsiveSizer(
                  builder: (context, orientation, screenType) =>
                      MaterialApp.router(
                    routerConfig: getIt<AppRouter>().router,
                    debugShowCheckedModeBanner: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
