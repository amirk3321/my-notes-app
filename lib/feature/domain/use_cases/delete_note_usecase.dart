
import 'package:mynotes/feature/domain/entities/note_entity.dart';
import 'package:mynotes/feature/domain/repositories/firebase_repository.dart';

class DeleteNoteUseCase {

  final FirebaseRepository repository;

  DeleteNoteUseCase({required this.repository});

  Future<void> call(NoteEntity note)async{
    return repository.deleteNote(note);
  }
}