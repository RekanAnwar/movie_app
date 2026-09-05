import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/pages/pages.dart';
import 'package:movie_app/themes/themes.dart';
import 'package:movie_app/utils/logging.dart';

Future<void> main() async {
  await dotenv.load();

  FlutterError.presentError = (details) => talker.error(
    details.exceptionAsString(),
    details.exception,
    details.stack,
  );

  FlutterError.onError = (details) => talker.error(
    details.exceptionAsString(),
    details.exception,
    details.stack,
  );

  PlatformDispatcher.instance.onError = (error, stack) {
    talker.error(error.toString(), error, stack);

    return true;
  };

  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData(fontFamily: 'Poppins').textTheme;
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      home: const HomePage(),
    );
  }
}
