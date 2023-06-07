import 'package:adviser/data/datasource/advice_remote_datasource.dart';
import 'package:adviser/data/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:adviser/domain/failures/failures.dart';

import 'package:adviser/domain/entities/advice_entity.dart';

import '../../domain/repositories/advice_repo.dart';

class AdviceRepoImple implements AdviceRepo {
  AdviceRepoImple({required this.adviceRemoteDatasource});
  final AdviceRemoteDatasource adviceRemoteDatasource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
