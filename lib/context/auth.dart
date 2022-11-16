import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:one_context/one_context.dart';

class AuthProvider extends ChangeNotifier {

  static final Config config = Config(
    tenant: "96afbc18-edff-42b5-bdf0-044419200442",
    clientId: "042396c2-65c6-4b76-ad04-010e0bf678ae",
    scope: "openid profile offline_access api://6136c1dd-88f1-4068-984b-db0b74993708/admin.read api://6136c1dd-88f1-4068-984b-db0b74993708/admin.write",
    redirectUri: "https://login.live.com/oauth20_desktop.srf",
    navigatorKey: OneContext().key,
  );

  static final AadOAuth oauth = AadOAuth(config);

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login() async {
    try {
      await oauth.login();
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await oauth.logout();
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await oauth.getAccessToken();
    } catch (e) {
      print(e);
      return null;
    }
  }

}