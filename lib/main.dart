import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/bloc/provider.dart';
import 'package:valiu_challenge/src/pages/amount_list_page.dart';
import 'package:valiu_challenge/src/pages/new_amount_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'list',
        home: AmountListPage(),
        routes: {
          'list': (BuildContext context) => AmountListPage(),
          'new-amount': (BuildContext context) => NewAmountPage()
        },
        theme: ThemeData(
            primaryColorBrightness: Brightness.light,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: Colors.grey)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style:
                    ElevatedButton.styleFrom(primary: Colors.indigo.shade900))),
      ),
    );
  }
}
