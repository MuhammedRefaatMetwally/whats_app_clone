import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/cores/routing/routes.dart';
import '../../features/user/presentation/cubit/auth/auth_cubit.dart';
import '../../features/user/presentation/cubit/credential/credential_cubit.dart';
import '../../features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import '../../features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import '../../features/user/presentation/cubit/user/user_cubit.dart';
import '../../features/user/presentation/screens/login_page.dart';
import '../app/home/home_page.dart';
import '../app/splash/splash_screen.dart';
import 'package:whats_app_clone/main_injection_container.dart' as di;

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.welcomePage:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) =>
                di.sl<AuthCubit>()
                  ..appStarted(),
                child: const AuthWrapper(),
              ),
        );

      case Routes.loginPage:
        {
          return MaterialPageRoute(builder: (_) =>
              BlocProvider(
                  create: (BuildContext context) =>
                      di.sl<CredentialCubit>(),
                  child: const LoginPage()));
        }
      default:
        return null;
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return MultiBlocProvider(providers: [
            BlocProvider(create:(context) => di.sl<GetSingleUserCubit>(),)
          ],
          child: HomePage(uid: authState.uid));
        }
        return SplashScreen();
      },
    );
  }
}

