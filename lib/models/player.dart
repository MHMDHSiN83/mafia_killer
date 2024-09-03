import 'package:flutter/foundation.dart';

class Player {
  Player(this._name);

  String _name;
  String get name => _name;
  set name(String? value) {
    if (value != null) {
      _name = value;
    }
    // TODO
    else {
      print("throw null exception");
    }
  }

  bool _doesParticipate = false;
  bool get doesParticipate => _doesParticipate;

  void changeStatus() {
    _doesParticipate = !_doesParticipate;
  }
}
