import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/usecases/advice_usecases.dart';
import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adviser_state.dart';

const generalFailureMessage = 'general failure';
const serverFailureMessage = 'server failure';
const cacheFailureMessage = 'cache failure';

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit({required this.adviseUseCases}) : super(AdviserInitial());

  final AdviceUseCases adviseUseCases;

  void adviceRequested() async {
    emit(AdviserStateLoading());

    final Either<Failure, AdviceEntity> advice =
        await adviseUseCases.getAdvice();
    advice.fold(
      (failure) =>
          emit(AdviserStateError(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdviserStateLoaded(advice: advice.advice)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailrue:
        return cacheFailureMessage;
      case GeneralFailure:
        return generalFailureMessage;
      default:
        return 'default failure';
    }
  }
}
