import 'package:dmggo/microsoftAuth/helper/choose_oauth.dart';
import 'package:dmggo/microsoftAuth/model/config.dart';


class CoreOAuth {
  CoreOAuth();

  Future<void> login({bool refreshIfAvailable = false}) async {}

  Future<void> logout() async {}

  Future<String?> getAccessToken() async => 'ACCESS_TOKEN';

  Future<String?> getIdToken() async => 'ID_TOKEN';

  factory CoreOAuth.fromConfig(Config config) =>
      config.isStub ? CoreOAuth() : getOAuthConfig(config);
}
