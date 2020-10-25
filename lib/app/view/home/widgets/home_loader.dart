

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget progressLoader({double size}) {
  return  Center(
    child: SpinKitCircle(
      size: size,
      color: Colors.black,
    ),
  );
}