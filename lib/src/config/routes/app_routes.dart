import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/src/core/utils/app_strings.dart';
import 'package:quotes/src/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/src/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:quotes/injection_container.dart' as di;
import 'package:quotes/src/features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = "/";
  static const String randomQuoteRoute = "/randomQuote";
}

// in case of named routes
// final routes = {
//   Routes.initialRoute : (context) => QuoteScreen(),
//   Routes.favRoute : (context) => FavQuoteScreen(),
// };

// Genrated Routes
class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case Routes.randomQuoteRoute:
        return MaterialPageRoute(
            builder: (contect) => BlocProvider(
                create: (context) => di.sl<RandomQuoteCubit>(),
                child: const QuoteScreen()));

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
