import 'package:eurosanpro/bindings/general_bindings.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}
