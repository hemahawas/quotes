import 'package:dartz/dartz.dart';
import 'package:quotes/src/core/error/failure.dart';
import 'package:quotes/src/core/usecase/usecase.dart';
import 'package:quotes/src/features/splash/domain/repositories/lang_repository.dart';

class GetSavedLangUseCase implements Usecase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await langRepository.getSavedLang();
}
