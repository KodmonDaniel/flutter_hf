import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'login_bloc.dart';
import 'package:custom_top_navigator/custom_scaffold.dart';
import 'package:async/async.dart';

class Login extends StatefulWidget {
  const Login ({Key? key});
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _bloc = LoginBloc();

    return BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 50,),
                  TextField(
                    controller: emailInputController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "E-mail"),
                  ),

                  TextField(
                    controller: passwordInputController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "E-mail"),
                  ),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    icon: const Icon(Icons.lock_clock_outlined),
                    label: Text("LOGIN"), //TODO STYLE
                    onPressed: _signIn,
                  )
                ],
              ),
            ),
          );
        }
      )
    );
  }

  Future _signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInputController.text.trim(),
        password: passwordInputController.text.trim());


    final user = FirebaseAuth.instance.currentUser!;
    //print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!: " + user.runtimeType!.toString());
    //todo move to bloc/repo
  }


}



