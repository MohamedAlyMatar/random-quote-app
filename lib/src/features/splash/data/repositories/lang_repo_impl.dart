import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/errors/exceptions.dart';
import 'package:quotes/src/core/errors/failures.dart';
import 'package:quotes/src/features/splash/data/datasources/lang_local_data_src.dart';
import 'package:quotes/src/features/splash/domain/repositories/lang_repo.dart';

class LangRepoImpl implements LangRepo {
  final LangLocalDataSrc langLocalDataSrc;
  LangRepoImpl({required this.langLocalDataSrc});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged =
          await langLocalDataSrc.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocalDataSrc.getSavedLang();
      return Right(langCode);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
