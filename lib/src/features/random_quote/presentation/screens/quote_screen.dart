import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/src/config/locale/app_localizations.dart';
import 'package:quotes/src/core/utils/app_colors.dart';
import 'package:quotes/src/core/utils/app_strings.dart';
import 'package:quotes/src/features/random_quote/domain/useCases/get_random_quote.dart';
import 'package:quotes/src/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/src/features/random_quote/presentation/cubit/random_quote_state.dart';
import 'package:quotes/src/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:quotes/src/core/widgets/error_widget.dart' as error_widget;
import 'package:quotes/src/features/splash/presentation/cubit/locale_cubit.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  GetRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    GetRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: ((context, state) {
      if (state is RandomQuoteIsLoading) {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primaryColor,
          ),
        );
      } else if (state is RandomQuoteError) {
        return error_widget.ErrorWidget(
          onpress: () => GetRandomQuote(),
        );
      } else if (state is RandomQuoteLoaded) {
        return Column(
          children: [
            QuoteContent(
              quote: state.quote,
            ),
            InkWell(
                onTap: () => GetRandomQuote(),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primaryColor),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                ))
          ],
        );
      } else {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primaryColor,
          ),
        );
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.translate_outlined,
          color: AppColors.primaryColor,
        ),
        onPressed: () {
          if (AppLocalizations.of(context)!.isEnLocale) {
            BlocProvider.of<LocaleCubit>(context).toArabic();
          } else {
            BlocProvider.of<LocaleCubit>(context).toEnglish();
          }
        },
      ),
      title: Text(AppLocalizations.of(context)!.translate('app_name')!),
    );
    return RefreshIndicator(
        child: Scaffold(
          appBar: appBar,
          body: _buildBodyContent(),
        ),
        onRefresh: () => GetRandomQuote());
  }
}
