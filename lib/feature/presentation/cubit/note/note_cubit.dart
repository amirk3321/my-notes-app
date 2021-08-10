import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mynotes/feature/domain/entities/note_entity.dart';
import 'package:mynotes/feature/domain/use_cases/add_new_note_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/delete_note_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:mynotes/feature/domain/use_cases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNotesUseCase getNotesUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  NoteCubit({required this.getNotesUseCase,required this.deleteNoteUseCase,required this.updateNoteUseCase,required this.addNewNoteUseCase}) : super(NoteInitial());


  Future<void> addNote({required NoteEntity note})async{
    try{
     await addNewNoteUseCase.call(note);
    }on SocketException catch(_){
      emit(NoteFailure());
    }catch(_){
      emit(NoteFailure());
    }
  }

  Future<void> deleteNote({required NoteEntity note})async{
    try{
      await deleteNoteUseCase.call(note);
    }on SocketException catch(_){
      emit(NoteFailure());
    }catch(_){
      emit(NoteFailure());
    }
  }
  Future<void> updateNote({required NoteEntity note})async{
    try{
      await updateNoteUseCase.call(note);
    }on SocketException catch(_){
      emit(NoteFailure());
    }catch(_){
      emit(NoteFailure());
    }
  }

  Future<void> getNotes({required String uid})async{
    emit(NoteLoading());
    try{
      getNotesUseCase.call(uid).listen((notes) {
        emit(NoteLoaded(notes: notes));
      });
    }on SocketException catch(_){
      emit(NoteFailure());
    }catch(_){
      emit(NoteFailure());
    }
  }

}
