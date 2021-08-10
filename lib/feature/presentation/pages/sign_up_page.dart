


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/app_const.dart';
import 'package:mynotes/feature/domain/entities/user_entity.dart';
import 'package:mynotes/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:mynotes/feature/presentation/cubit/user/user_cubit.dart';
import 'package:mynotes/feature/presentation/widgets/common.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
        body: BlocConsumer<UserCubit,UserState>(
          builder: (context,userState){

            if (userState is UserSuccess){
              return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){

                if (authState is Authenticated){
                  return HomePage(uid: authState.uid,);
                }else{
                  return _bodyWidget();
                }
              });
            }

            return _bodyWidget();
          },
          listener: (context,userState){
            if (userState is UserSuccess){
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (userState is UserFailure){
              snackBarError(msg: "invalid email",scaffoldState: _globalKey);
            }
          },
        )
    );
  }

  _bodyWidget() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);
            },
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(.6)),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  hintText: 'Username', border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'Enter your email', border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter your Password', border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: (){
              submitSignIn();
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(.8),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                "Create New Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void submitSignIn() {
    if (_usernameController.text.isNotEmpty &&_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}
