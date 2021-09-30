//import 'package:contatos/pages/contato_page.dart';

import 'package:partilhe/pages/dashboard.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        accentColor: Colors.lightBlue[50],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightBlue[700],
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
