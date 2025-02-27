/*
import 'package:flutter/material.dart';
import '../helpers/constants.dart';

class OnGenerateRoute {


  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case PageConst.contactUsersPage:
        {
          if(args is String) {
            return materialPageBuilder(ContactsPage(uid: args,));

          } else {
            return materialPageBuilder( const ErrorPage());

          }
        }
      case PageConst.settingsPage: {
        if(args is String) {
          return materialPageBuilder( SettingsPage(uid: args));
        } else {
          return materialPageBuilder( const ErrorPage());
        }
      }
      case PageConst.editProfilePage: {
        if(args is UserEntity) {
          return materialPageBuilder( EditProfilePage(currentUser: args));
        } else {
          return materialPageBuilder( const ErrorPage());
        }
      }
      case PageConst.callContactsPage: {
        return materialPageBuilder(const CallContactsPage());

      }
      case PageConst.myStatusPage: {
        if(args is StatusEntity) {
          return materialPageBuilder( MyStatusPage(status: args));
        } else {
          return materialPageBuilder( const ErrorPage());
        }
      }
      case PageConst.callPage: {
        if(args is CallEntity) {
          return materialPageBuilder( CallPage(callEntity: args));
        } else {
          return materialPageBuilder( const ErrorPage());
        }
      }
      case PageConst.singleChatPage: {
        if(args is MessageEntity) {
          return materialPageBuilder( SingleChatPage(message: args));
        } else {
          return materialPageBuilder( const ErrorPage());
        }

      }
    }


   }

  }

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

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
*/
