import 'package:flutter_modular/flutter_modular.dart';
import 'modules/home/home_module.dart';
import 'shared/services/just_audio.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(
      AudioService.new,
    ); // O serviço nasce apenas quando for usado
  }

  @override
  void routes(r) {
    // A rota '/' carrega o módulo Home (Tela Principal)
    r.module('/', module: HomeModule());
  }
}
