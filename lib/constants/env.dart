import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/utils/logging.dart';

class Env {
  const Env._();

  static String get accessToken {
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    if (accessToken == null || accessToken.isEmpty) {
      const errorMessage =
          'ACCESS_TOKEN is not set, please check your .env file';

      talker.critical(errorMessage);

      throw Exception(errorMessage);
    }

    return accessToken;
  }
}
