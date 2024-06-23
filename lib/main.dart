import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/cores/routing/app_router.dart';
import 'package:whats_app_clone/whats_app_clone.dart';
import 'cores/di/dependency_injection.dart';
import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp( WhatsAppClone(appRouter: AppRouter(),));
}


