import 'package:flutter_modular/flutter_modular.dart';
import 'presenter/home_page.dart';
import 'presenter/home_store.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    // Injetamos a Store que vai controlar o cronômetro
    i.addLazySingleton(HomeStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
