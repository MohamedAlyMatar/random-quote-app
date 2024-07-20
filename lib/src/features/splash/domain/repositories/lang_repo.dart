import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/errors/failures.dart';

abstract class LangRepo {
  Future<Either<Failures, bool>> changeLang({required String langCode});
  Future<Either<Failures, String>> getSavedLang();
}
