import 'package:billing_app/constants.dart';
import 'package:billing_app/views/base._view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Constants.detailColor,
          displayColor: Constants.detailColor,
          fontFamily: 'dubay',
        );

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Billing App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Constants.themeColor,
          fontFamily: 'dubay',
          textTheme: newTextTheme,
        ),
        home: BaseView(0),
      );
    });
  }
}
