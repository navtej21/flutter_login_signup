import 'package:course_basic/firebase_options.dart';
import 'package:course_basic/function/auth_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: Main()));
}

class Main extends StatefulWidget {
  const Main({super.key});

  State<Main> createState() => MainPage();
}

class MainPage extends State<Main> {
  String email = "";
  String password = "";
  String username = "";
  final formkey = GlobalKey<FormState>();
  bool _islogin = false;
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              'Email And Password Auth',
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: Center(
              child: Container(
            height: 350,
            color: Colors.red.shade100,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _islogin
                    ? TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: ValueKey('username'),
                        decoration: InputDecoration(hintText: 'enter username'),
                        validator: (value) {
                          if (value.toString().length < 3) {
                            return 'username is so small';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            username = value!;
                          });
                        })
                    : Container(),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(hintText: 'enter email'),
                  validator: (value) {
                    if (!(value.toString().contains('@'))) {
                      return 'email invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  key: ValueKey('password'),
                  decoration: InputDecoration(hintText: 'password'),
                  validator: (value) {
                    if (value.toString().length < 6) {
                      return 'password too small';
                    }
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            _islogin?signup(email,password):signin(email,password);
                          }
                        },
                        child: _islogin ? Text('Sign-Up') : Text('Login'))),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _islogin = !_islogin;
                      });
                    },
                    child: !_islogin
                        ? Text('Create a new account')
                        : Text(('Already Signed-In? Just Log-In')))
              ],
            ),
          ))),
    );
  }
}
