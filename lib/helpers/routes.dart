import 'package:flutter/material.dart';
import 'package:services_worker/screens/profile/edit_work.dart';
import 'package:services_worker/screens/profile/terms_conditions.dart';
import 'package:services_worker/screens/tabs/booking_history.dart';
import 'package:services_worker/screens/tabs/invoice_preview.dart';

import '../screens/forgot_password.dart';
import '../screens/login.dart';

import '../screens/profile/edit_profile.dart';
import '../screens/profile/help_support.dart';
import '../screens/register.dart';
import '../screens/register_work.dart';
import '../screens/home.dart';
import '../screens/tabs/booking.dart';
import '../screens/tabs/invoice.dart';
import '../screens/tabs/profile.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      // case ProductListScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => ProductListScreen(args: args as Map),
      //   );
      // case ProductDetailScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => ProductDetailScreen(productId: args as String),
      //   );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case RegisterWorkScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterWorkScreen(),
        );
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );

      case ProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      case EditProfile.routeName:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
        );
      case InvoiceScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const InvoiceScreen(),
        );
      case BookingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const BookingScreen(),
        );
      case BookingHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const BookingHistoryScreen(),
        );
      case InvoicePreview.routeName:
        return MaterialPageRoute(
          builder: (context) => InvoicePreview(link: args as String),
        );
      // case OrderDetail.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => OrderDetail(orderId: args as String),
      //   );
      case EditWorkSettings.routeName:
        return MaterialPageRoute(
          builder: (context) => EditWorkSettings(),
        );
      case TermsConditions.routeName:
        return MaterialPageRoute(
          builder: (context) => TermsConditions(),
        );
      case HelpSupport.routeName:
        return MaterialPageRoute(
          builder: (context) => HelpSupport(),
        );
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('ERROR')),
          body: const Center(
            child: Text("Page not found"),
          ),
        );
      },
    );
  }
}
