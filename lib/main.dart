import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/app.router.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/dependency_injection.dart';
import 'package:partilhe/routes/rotas.dart';

void main() {
  DependencyInjection(GetIt.instance);

  runApp(PartilheApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class PartilheApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        accentColor: Colors.lightBlue[50],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightBlue[700],
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      /*  home: Dashboard(), */
      navigatorKey: AppRouter.chaveDeNavegacao,
      onGenerateRoute: AppRouter.gerarRotas,
      initialRoute: rotaDashboard,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
    );
  }
}
