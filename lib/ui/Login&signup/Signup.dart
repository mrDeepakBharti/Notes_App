import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_sqflite/DBHelper/DBHelper.dart';
import 'package:flutter_notes_app_with_sqflite/Widgets/ResuableRow.dart';
import 'package:flutter_notes_app_with_sqflite/Widgets/RoundedButton.dart';
import 'package:flutter_notes_app_with_sqflite/loginModel/User.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/utils.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final username = TextEditingController();
  final emailText = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  final dbhelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff02084B),
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          child: Column(
            children: [
              Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter name';
                          } else {
                            return null;
                          }
                        },
                        controller: username,
                        decoration: InputDecoration(
                            hintText: 'Enter Name',
                            suffixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            } else {
                              return null;
                            }
                          },
                          controller: emailText,
                          decoration: InputDecoration(
                              hintText: 'email',
                              suffixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0))))),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            } else {
                              return null;
                            }
                          },
                          controller: password,
                          decoration: InputDecoration(
                              hintText: 'password',
                              suffixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0))))),
                      SizedBox(
                        height: 20.0,
                      ),
                      /*  TextFormField(
                          controller: confirm,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              suffixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)))))*/
                      SizedBox(
                        height: 20.0,
                      ),
                      RoundButton(
                          title: 'Sign Up',
                          onTap: () async {
                            if (keyForm.currentState!.validate()) {
                              final name = username.text;
                              final email = emailText.text;
                              final Password = password.text;
                              UserModel? emailexist =
                                  await dbhelper.getUser(email);

                              if (emailexist != null) {
                                return Utils()
                                    .toastMessage('Email is Already Exist');
                              } else {
                                final newUser = UserModel(
                                    name: name,
                                    email: email,
                                    password: Password);
                                await dbhelper
                                    .insertUser(newUser)
                                    .then((value) => {
                                          Utils().toastMessage(
                                              'User create SuccessFully')
                                        })
                                    .onError((error, stackTrace) => {
                                          Utils().toastMessage(error.toString())
                                        });
                              }
                            }
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      ResuableRow(
                          title: 'Login',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
