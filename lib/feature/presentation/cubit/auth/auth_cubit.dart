import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mynotes/feature/domain/use_cases/get_current_uid_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/is_sign_in_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  AuthCubit({required this.isSignInUseCase,required this.signOutUseCase,required this.getCurrentUidUseCase}) : super(AuthInitial());

  Future<void> appStarted()async{
    try{
      final isSignIn=await isSignInUseCase.call();
      if (isSignIn){
        final uid=await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      }else{
        emit(UnAuthenticated());
      }


    }on SocketException catch(_){
      emit(UnAuthenticated());
    }


  }


  Future<void> loggedIn()async{
    try{
      final uid=await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    }on SocketException catch(_){
      emit(UnAuthenticated());
    }

  }
  Future<void> loggedOut()async{
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }on SocketException catch(_){
      emit(UnAuthenticated());
    }

  }
}
