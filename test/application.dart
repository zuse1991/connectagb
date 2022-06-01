import 'package:conecta_gb/commom/logs/logger.dart';
import 'package:conecta_gb/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ConectaGBTestApp extends StatelessWidget {
  final Widget? home;

  const ConectaGBTestApp({this.home, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    return MaterialApp(
        title: 'Conecta GB',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: home,
        routes: appRoutes,
        localizationsDelegates: [
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
                basePath: 'assets/i18n', fallbackFile: 'pt_BR'),
            missingTranslationHandler: (key, locale) {
              logger.d(
                  "--- Missing Key: $key, languageCode: ${locale?.languageCode}");
            },
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        builder: FlutterI18n.rootAppBuilder());
  }
}
