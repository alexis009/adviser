import 'package:adviser/data/repositories/advice_repo_imple.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
    //spacing
  }
}
