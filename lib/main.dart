import 'package:flutter/material.dart';
import 'package:state_management/provider/cart.dart';
import 'package:state_management/reactive_experience/counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter state management',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            // home: MyRxDartPage(),
            home: MyItemsPage(),
        );
    }
}
