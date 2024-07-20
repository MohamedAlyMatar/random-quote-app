import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/errors/failures.dart';
import 'package:quotes/src/core/use_cases/use_case.dart';
import 'package:quotes/src/features/splash/domain/repositories/lang_repo.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepo langRepo;

  ChangeLangUseCase({required this.langRepo});

  @override
  Future<Either<Failures, bool>> call(String langCode) async =>
      await langRepo.changeLang(langCode: langCode);
}
