import 'package:capsule_toast/capsule_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/pages/pages.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/themes/themes.dart';
import 'package:movie_app/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  final sharedPreferences = await SharedPreferences.getInstance();

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
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          sharedPreferences,
        ),
      ],
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends ConsumerWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = ThemeData(fontFamily: 'Poppins').textTheme;
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      home: const ToastBuilder(child: HomePage()),
      builder: (context, child) => CapsuleToastHost(child: child!),
    );
  }
}

class ToastBuilder extends ConsumerWidget {
  const ToastBuilder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      toastNotifierProvider,
      (previous, next) {
        if (next != null) {
          CapsuleToastHost.of(context).show(next);
        }
      },
    );

    return child;
  }
}
