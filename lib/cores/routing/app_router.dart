import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/cores/routing/routes.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/pages/chat_page.dart';
import '../../features/call/domain/entities/call_entity.dart';
import '../../features/call/presentation/cubits/my_call_history/my_call_history_cubit.dart';
import '../../features/call/presentation/pages/call_contacts_page.dart';
import '../../features/call/presentation/pages/call_page.dart';
import '../../features/chat/domain/entities/chat_entity.dart';
import '../../features/chat/domain/entities/message_entity.dart';
import '../../features/chat/presentation/pages/single_chat_page.dart';
import '../../features/status/domain/entities/status_entity.dart';
import '../../features/status/presentation/cubit/status/status_cubit.dart';
import '../../features/status/presentation/pages/my_status_page.dart';
import '../../features/user/domain/entities/user_entity.dart';
import '../../features/user/presentation/cubit/auth/auth_cubit.dart';
import '../../features/user/presentation/cubit/credential/credential_cubit.dart';
import '../../features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import '../../features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import '../../features/user/presentation/cubit/user/user_cubit.dart';
import '../../features/user/presentation/screens/edit_profile_page.dart';
import '../../features/user/presentation/screens/login_page.dart';
import '../app/home/contacts_page.dart';
import '../app/home/home_page.dart';
import '../app/settings/settings_page.dart';
import '../app/splash/splash_screen.dart';
import 'package:whats_app_clone/main_injection_container.dart' as di;

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.welcomePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di.sl<AuthCubit>()..appStarted(),
            child: const AuthWrapper(),
          ),
        );

      case Routes.loginPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (BuildContext context) => di.sl<CredentialCubit>(),
                  child: const LoginPage()));
        }

      case Routes.contactUsersPage:
        {
          if (arguments is String) {
            return materialPageBuilder(MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => di.sl<UserCubit>()..getAllUsers(),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<GetSingleUserCubit>()
                      ..getSingleUser(uid: arguments),
                  ),
                ],
                child: ContactsPage(
                  uid: arguments,
                )));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case Routes.settingsPage:
        {
          if (arguments is String) {
            return materialPageBuilder(BlocProvider(
                create: (context) =>
                    di.sl<GetSingleUserCubit>()..getSingleUser(uid: arguments),
                child: SettingsPage(uid: arguments)));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case Routes.editProfilePage:
        {
          if (arguments is UserEntity) {
            return materialPageBuilder(EditProfilePage(currentUser: arguments));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case Routes.callContactsPage:
        {
          return materialPageBuilder(const CallContactsPage());
        }
      case Routes.callPage:
        {
          if (arguments is CallEntity) {
            return materialPageBuilder(CallPage(callEntity: arguments));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case Routes.singleChatPage:
        {
          if (arguments is MessageEntity) {
            return materialPageBuilder(MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => di.sl<GetSingleUserCubit>()
                  ..getSingleUser(uid: arguments.uid!),
              ),
              BlocProvider(
                create: (context) =>
                    di.sl<MessageCubit>()..getMessages(message: arguments),
              ),
            ], child: SingleChatPage(message: arguments)));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }

      case Routes.chatPage:
        {
          if (arguments is String) {
            return materialPageBuilder(BlocProvider(
                create: (context) => di.sl<ChatCubit>()
                  ..getMyChat(chat: ChatEntity(senderUid: arguments)),
                child: ChatPage(
                  uid: arguments,
                )));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }

      case Routes.myStatusPage: {
        if(arguments is StatusEntity) {
          return materialPageBuilder( MyStatusPage(status: arguments));
        } else {
          return materialPageBuilder( const ErrorPage());
        }
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
            BlocProvider(
              create: (context) => di.sl<GetSingleUserCubit>()
                ..getSingleUser(uid: authState.uid),
            ),
            BlocProvider(
              create: (context) => di.sl<MyCallHistoryCubit>()
                ..getMyCallHistory(uid: authState.uid),
            ),BlocProvider(
              create: (context) => di.sl<StatusCubit>(),
            ),

          ], child: HomePage(uid: authState.uid));
        }
        return SplashScreen();
      },
    );
  }
}

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}
