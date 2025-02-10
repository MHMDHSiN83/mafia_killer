import 'package:flutter/material.dart';

mixin PageReloader<T extends StatefulWidget> on State<T> {
  void reloadPage() {
    setState(() {}); // Triggers UI rebuild
  }
}