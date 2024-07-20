// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quotes/app.dart';
// import 'package:quotes/bloc_observer.dart';
// import 'injection_container.dart' as di;

// // void main() {
// //   runApp(const QuoteApp());
// // }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // BindingBase.debugZoneErrorsAreFatal = true;
//   await di.init();
//   BlocOverrides.runZoned(() {
//     runApp(const QuoteApp());
//   }, blocObserver: AppBlocObserver());
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/app.dart';
import 'bloc_observer.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = AppBlocObserver();
  runApp(
    const QuoteApp(),
  );
}
