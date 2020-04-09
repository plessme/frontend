import 'package:flutter/material.dart';
import 'package:plessme_ui/authentication_provider.dart';

class SecondPage extends StatelessWidget {
  // This is a String for the sake of an example.
  // You can use any type you want.
  final String data;

  SecondPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLessMe App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Second Page',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              data,
              style: TextStyle(fontSize: 20),
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                AuthenticationProvider authentication =
                    AuthenticationProvider();
                authentication.getDatabaseContent();
                authentication.killDatabase();
                // Pushing a route directly, WITHOUT using a named route
                Navigator.of(context).pushNamed(
                  '/',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}