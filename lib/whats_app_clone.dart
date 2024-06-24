import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cores/app/theme/style.dart';
import 'cores/routing/app_router.dart';
import 'cores/routing/routes.dart';

class WhatsAppClone extends StatelessWidget {
  final AppRouter appRouter;

  const WhatsAppClone({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: "whats app clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
                seedColor: tabColor, brightness: Brightness.dark),
            scaffoldBackgroundColor: backgroundColor,
            dialogBackgroundColor: appBarColor,
            appBarTheme: const AppBarTheme(
              color: appBarColor,
            )),
        initialRoute: Routes.welcomePage,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
