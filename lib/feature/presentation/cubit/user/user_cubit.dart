import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mynotes/feature/domain/entities/user_entity.dart';
import 'package:mynotes/feature/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/sign_in_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUPUseCase signUPUseCase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUseCase;
  UserCubit({required this.signUPUseCase,required this.signInUseCase,required this.getCreateCurrentUserUseCase}) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user})async{
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    }on SocketException catch(_){
      emit(UserFailure());
    } catch(_){
      emit(UserFailure());
    }
  }
  Future<void> submitSignUp({required UserEntity user})async{
    emit(UserLoading());
    try {
      await signUPUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);
      emit(UserSuccess());
    }on SocketException catch(_){
      emit(UserFailure());
    } catch(_){
      emit(UserFailure());
    }

  }
}
