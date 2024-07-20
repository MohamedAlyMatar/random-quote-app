import 'package:dartz/dartz.dart';
import 'package:quotes/src/features/random_quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  QuoteModel({
    required super.a,
    required super.q,
    required super.h,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        a: json["a"],
        q: json["q"],
        h: json["h"],
      );

  Map<String, dynamic> toJson() => {
        "a": a,
        "q": q,
        "h": h,
      };
}
