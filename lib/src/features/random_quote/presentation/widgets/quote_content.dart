import 'package:flutter/material.dart';
import 'package:quotes/src/core/utils/app_colors.dart';
import 'package:quotes/src/features/random_quote/domain/entities/quote.dart';

class QuoteContent extends StatelessWidget {
  final Quote quote;
  const QuoteContent({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Column(children: [
              Text(quote.q,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(quote.a,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium))
            ]),
          ],
        ));
  }
}
