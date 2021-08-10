

import 'package:mynotes/feature/domain/repositories/firebase_repository.dart';

class SignOutUseCase {

  final FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call()async{
    return repository.signOut();
  }
}