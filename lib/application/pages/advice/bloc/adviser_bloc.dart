import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adviser_event.dart';
part 'adviser_state.dart';

class AdviserBloc extends Bloc<AdviserEvent, AdviserState> {
  AdviserBloc() : super(AdviserInitial()) {
    on<AdviceRequestedEvents>((event, emit) async {
      emit(AdviserStateLoading());
      print('test');
      await Future.delayed(const Duration(seconds: 3), () {});
      print('test 2');
      emit(AdviserStateLoaded(advice: 'test advice'));
    });
  }
}
