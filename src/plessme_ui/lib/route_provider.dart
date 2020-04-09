import 'package:flutter/material.dart';
import 'package:plessme_ui/authentication_provider.dart';
import 'package:plessme_ui/views/root/login_page.dart';
import 'package:plessme_ui/views/second_page.dart';

class RouteProvider {

  static AuthenticationProvider authentication = AuthenticationProvider();
  static Route<dynamic> provideRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/second':
        // Validation of correct data type
        // if (args is String) {
        return MaterialPageRoute(
          builder: (_) => SecondPage(
            data: authentication.username,
          ),
        );
      // }
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      // return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
