


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app_const.dart';
import 'package:mynotes/feature/presentation/pages/sign_in_page.dart';

import 'feature/domain/entities/note_entity.dart';
import 'feature/presentation/pages/add_new_note_page.dart';
import 'feature/presentation/pages/sign_up_page.dart';
import 'feature/presentation/pages/update_note_page.dart';

class OnGenerateRoute{
  static Route<dynamic> route(RouteSettings settings){
    final args=settings.arguments;


    switch(settings.name){
      case PageConst.signInPage:{
        return materialBuilder(widget: SignInPage());
        break;
      }
      case PageConst.signUpPage:{
        return materialBuilder(widget: SignUpPage());
        break;
      }
      case PageConst.addNotePage:{
        if (args is String) {
          return materialBuilder(widget: AddNewNotePage(uid: args,));
        }
        else {
          return materialBuilder(
            widget: ErrorPage(),
          );
        }
        break;
      }
      case PageConst.UpdateNotePage:{
        if (args is NoteEntity) {
          return materialBuilder(widget: UpdateNotePage(noteEntity: args,));
        }
        else {
          return materialBuilder(
            widget: ErrorPage(),
          );
        }
        break;
      }
      default: return materialBuilder(widget: ErrorPage());
    }

  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}