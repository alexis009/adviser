part of 'adviser_bloc.dart';

@immutable
abstract class AdviserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviserInitial extends AdviserState {}

class AdviserStateLoading extends AdviserState {}

class AdviserStateLoaded extends AdviserState {
  final String advice;
  AdviserStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdviserStateError extends AdviserState {
  final String message;
  AdviserStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
