import 'package:firebasetodoapps/screens/forget_password_screen.dart';
import 'package:firebasetodoapps/screens/login_screen.dart';
import 'package:firebasetodoapps/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../screens/recycle_bin.dart';
import '../screens/tabs_screens.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBin(),
        );
      case TabsScreen.id:
        return MaterialPageRoute(
          builder: (_) => const TabsScreen(),
        );
      case RegisterScreen.id:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      default:
        return null;
    }
  }
}
