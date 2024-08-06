// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// import 'package:flutter/material.dart';
// import 'package:hele_app/Application.dart';
// import 'package:hele_app/src/rust/frb_generated.dart';
//
// Future<void> main() async {
//   await RustLib.init();
//   runApp(const Application());
// }
//

import 'package:flutter/material.dart';
import 'package:hele_app/Application.dart';
import 'package:hele_app/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const Application());
}
