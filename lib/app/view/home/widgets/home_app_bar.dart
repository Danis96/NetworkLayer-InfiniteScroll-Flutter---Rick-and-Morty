import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget homeAppBar() {
  return AppBar(
    title: const Text(
      'Rick and Morty Characters',
      style: TextStyle(color: Colors.black),
    ),
    elevation: 1,
    backgroundColor: Colors.white,
  );
}
