import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String a;
  final String q;
  final String h;

  Quote(
      {required this.a,
      required this.q,
      required this.h});

  @override
  List<Object?> get props => [a, q, h];
}
