

import 'package:mynotes/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:mynotes/feature/domain/entities/note_entity.dart';
import 'package:mynotes/feature/domain/entities/user_entity.dart';
import 'package:mynotes/feature/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl extends FirebaseRepository{
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> addNewNote(NoteEntity note) async =>
      remoteDataSource.addNewNote(note);

  @override
  Future<void> deleteNote(NoteEntity note) async =>
      remoteDataSource.deleteNote(note);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async =>
      remoteDataSource.getCurrentUId();

  @override
  Stream<List<NoteEntity>> getNotes(String uid) =>
      remoteDataSource.getNotes(uid);

  @override
  Future<bool> isSignIn() async =>
      remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async =>
      remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async =>
      remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      remoteDataSource.signUp(user);

  @override
  Future<void> updateNote(NoteEntity note) async =>
      remoteDataSource.updateNote(note);

}