//import 'package:contatos/pages/contato_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/routes/rotas.dart';

/* void main(){
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
   ) );
}
 */
void main() {
  runApp(PartilheApp());
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
