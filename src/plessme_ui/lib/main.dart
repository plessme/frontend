import 'dart:async';

import 'package:plessme_ui/route_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var bloc = MyAppBloc(databaseFactoryWeb);
  runApp(MyApp(
    bloc: bloc,
  ));
}

var valueKey = 'value';
var store = StoreRef<String, int>.main();
var record = store.record(valueKey);

class MyAppBloc {
  final DatabaseFactory databaseFactory;
  MyAppBloc(this.databaseFactory) {
    database = () async {
      var db = await databaseFactory.openDatabase('counter.db');
      return db;
    }();
    // Load counter on start
    () async {
      var db = await database;
      _streamSubscription = record.onSnapshot(db).listen((snapshot) {
        _counterController.add(snapshot?.value ?? 0);
      });
    }();
  }

  StreamSubscription _streamSubscription;

  Future<Database> database;

  final _counterController = StreamController<int>.broadcast();

  Stream<int> get counter => _counterController.stream;

  Future increment() async {
    var db = await database;
    await db.transaction((txn) async {
      var value = await record.get(txn) ?? 0;
      await record.put(txn, ++value);
      print('ouuu');
    });
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}

class MyApp extends StatelessWidget {
  final MyAppBloc bloc;

  const MyApp({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLessMe',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      // Initially display LoginPage
      initialRoute: '/',
      onGenerateRoute: RouteProvider.provideRoute,
    );
  }
}
