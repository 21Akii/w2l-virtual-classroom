import 'package:flutter/material.dart';
import 'package:watch2learn/routes/app_route.dart';
import 'package:watch2learn/theme/theme.dart';


void main() {
  runApp(const Watch2LearnApp());
}

class Watch2LearnApp extends StatelessWidget {
  const Watch2LearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Watch2Learn",
      theme: AppTheme.darkTheme,
      routerConfig: AppRoutes.router,
    );
  }
}
