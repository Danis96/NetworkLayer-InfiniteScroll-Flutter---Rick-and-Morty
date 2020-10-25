import 'package:flutter/material.dart';

extension OnString on String {
  Widget statusWidget() {
    switch (this) {
      case 'Dead':
        return const Icon(
          Icons.circle,
          color: Colors.red,
        );
        break;
      case 'Alive':
        return const Icon(
          Icons.circle,
          color: Colors.green,
        );
        break;
      case 'unknown':
        return const Icon(
          Icons.circle,
          color: Colors.grey,
        );
        break;
      default:
        return const Icon(
          Icons.circle,
          color: Colors.transparent,
        );
    }
  }
}
