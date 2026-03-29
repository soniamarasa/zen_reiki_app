import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Configura o Modular para gerenciar as rotas e o roteamento do MaterialApp
    return MaterialApp.router(
      title: 'Zen Reiki App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple, // Cor base para o Material 3
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}
