import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:plessme_ui/provider/encryption_provider.dart';

class AuthenticationProvider {
  // clientID (public) plessme-frontend
  // https://plessme.bongladesch.com/app
  final authorizationEndpoint =
      Uri.parse("http://example.com/oauth2/authorization");
  final tokenEndpoint = Uri.parse("http://example.com/oauth2/token");
  final clientID = "client identifier";

  String username;
  String password;
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  int notBeforePolicy;
  String sessionState;
  String scope;

  var store = intMapStoreFactory.store();
  var factory = databaseFactoryWeb;
  String databasename = 'plessme_session';
  SembastCodec codec = getEncryptSembastCodec(password: 'plessmepassword');
  // var db;

  Future openDatabase() async {
    // var db = await factory.openDatabase(databasename, codec: codec);
  }

  Future closeDatabase() async {
    // await this.db.close();
  }

  Future writeToDatabase(String name, String value) async {
    var db = await factory.openDatabase(databasename, codec: codec);
    await store.add(db, <String, dynamic>{'name': name, 'password': value});
    db.close();
  }

  Future getDatabaseContent() async {
    var db = await factory.openDatabase(databasename, codec: codec);
    print(await store.record(1).get(db));
    db.close();
  }

  Future killDatabase() async {
    await this.factory.deleteDatabase(databasename);
  }

  static final AuthenticationProvider _instance =
      AuthenticationProvider._internal();
  factory AuthenticationProvider() => _instance;

  AuthenticationProvider._internal() {
    this.username = 'PLessUsername'; //example
  }
}
