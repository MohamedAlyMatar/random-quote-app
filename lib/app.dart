// import 'package:flutter/material.dart';
// import 'package:quotes/src/config/routes/app_routes.dart';
// import 'package:quotes/src/config/themes/app_theme.dart';
// import 'package:quotes/src/core/utils/app_strings.dart';

// class QuoteApp extends StatelessWidget {
//   const QuoteApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: AppStrings.appName,
//       theme: appTheme(),
//       // routes: routes,
//       onGenerateRoute: AppRoutes.onGenerateRoute,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/src/config/locale/app_localizations_setup.dart';
import 'package:quotes/src/config/routes/app_routes.dart';
import 'package:quotes/src/config/themes/app_theme.dart';
import 'package:quotes/src/core/utils/app_strings.dart';
import 'package:quotes/src/features/random_quote/domain/useCases/get_random_quote.dart';
import 'package:quotes/src/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/src/features/splash/presentation/cubit/locale_state.dart';
import 'injection_container.dart' as di;

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLang()),
        // Add other BlocProviders here if needed
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previousState, currentState) {
          return previousState.locale != currentState.locale;
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: appTheme(),
            locale: state.locale,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
