import 'package:adviser/application/pages/advice/cubit/adviser_cubit.dart';
import 'package:adviser/data/datasource/advice_remote_datasource.dart';
import 'package:adviser/data/repositories/advice_repo_imple.dart';
import 'package:adviser/domain/repositories/advice_repo.dart';
import 'package:adviser/domain/usecases/advice_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  // !application layer
  //Factory = every time a new/fresh instance of that class
  sl.registerFactory(() => AdviserCubit(adviseUseCases: sl()));

  // !domain layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

  // !data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImple(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImpl(client: sl()));

  //! externs
  sl.registerFactory(() => http.Client());
}
