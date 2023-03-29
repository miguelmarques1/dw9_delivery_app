
import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get i {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color.fromRGBO(0, 125, 33, 1);

  Color get secondary => const Color.fromRGBO(248, 139, 12, 1);
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}