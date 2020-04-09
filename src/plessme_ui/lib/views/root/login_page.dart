import 'package:flutter/material.dart';
import 'package:plessme_ui/authentication_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLessMe App'),
      ),
      backgroundColor: Colors.blue[400],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'PLessMe',
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                AuthenticationProvider authentication =
                    AuthenticationProvider();
                authentication.writeToDatabase('PLessUser', 'PLessPassword');
                // Pushing a route directly, WITHOUT using a named route
                Navigator.of(context).pushNamed(
                  '/second',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
