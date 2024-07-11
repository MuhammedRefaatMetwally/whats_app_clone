import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/cores/routing/app_router.dart';
import 'package:whats_app_clone/whats_app_clone.dart';
import 'firebase_options.dart';
import 'main_injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await di.init();
  runApp( WhatsAppClone(appRouter: AppRouter(),));
}


