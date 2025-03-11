import 'package:flutter/material.dart';
import 'package:my_app/Screens/FeedbackPage.dart';
import 'package:my_app/Screens/sign_in_screen.dart';
import 'package:my_app/Screens/sign_up_screen.dart';
import 'package:my_app/Screens/ProfileScreen.dart';
import 'package:my_app/Screens/UploadImageScreen.dart';
import 'package:my_app/Screens/DetectionHistory.dart';
import 'package:my_app/Screens/HelpSupportPage.dart';

void main() {
  runApp(SafeEatsApp());
}

class SafeEatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeEats',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/signing',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/signing':
            return MaterialPageRoute(
              builder: (context) => SignInScreen(),
            );
          case '/signup':
            return MaterialPageRoute(
              builder: (context) => const SignUpScreen(),
            );
          case '/profile':
            if (settings.arguments != null) {
              final args = settings.arguments as Map<String, String>;
              return MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  username: args['username']!,
                  email: args['email']!,
                ),
              );
            }
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text("Invalid arguments for ProfileScreen")),
              ),
            );
          case '/uploadImage':
            return MaterialPageRoute(
              builder: (context) => UploadImageScreen(),
            );
          case '/detectionHistory':
            return MaterialPageRoute(
              builder: (context) => const DetectionHistory(),
            );
          case '/feedback': // Add Feedback page route
            return MaterialPageRoute(
              builder: (context) => const FeedbackPage(),
            );
          case '/helpSupport': // Add Help & Support page route
            return MaterialPageRoute(
              builder: (context) => const HelpSupportPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text("Page not found")),
              ),
            );
        }
      },
    );
  }
}
