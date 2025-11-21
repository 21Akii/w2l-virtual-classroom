
import 'package:go_router/go_router.dart';
import 'package:watch2learn/screens/auth/login/login.dart';
import 'package:watch2learn/screens/auth/regestration/registration.dart';


class AppRoutes {
  static final router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) =>  LoginScreen(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),
      // GoRoute(
      //   path: "/dashboard",
      //   builder: (context, state) => const DashboardScreen(),
      // ),
    ],
  );
}
