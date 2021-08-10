

import 'package:mynotes/feature/domain/entities/note_entity.dart';
import 'package:mynotes/feature/domain/repositories/firebase_repository.dart';

class UpdateNoteUseCase {

  final FirebaseRepository repository;

  UpdateNoteUseCase({required this.repository});

  Future<void> call(NoteEntity note)async{
    return repository.updateNote(note);
  }
}