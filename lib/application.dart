import 'package:conecta_gb/commom/logs/logger.dart';
import 'package:conecta_gb/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ConnectaGBApp extends StatelessWidget {
  const ConnectaGBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Conecta GB',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/sign-in',
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
