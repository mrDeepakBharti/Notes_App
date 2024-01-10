import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_sqflite/DBHelper/DBHelper.dart';
import 'package:flutter_notes_app_with_sqflite/Widgets/ResuableRow.dart';
import 'package:flutter_notes_app_with_sqflite/Widgets/RoundedButton.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/Home.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/utils.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/Signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailText = TextEditingController();
  final password = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  final db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xfff02084B),
        centerTitle: true,
        title: const Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Form(
                key: keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Enter password',
                          suffixIcon: Icon(Icons.lock_open),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    RoundButton(
                        title: 'Login',
                        onTap: () {
                          setState(() async {
                            if (keyForm.currentState!.validate()) {
                              final email = emailText.text;
                              final Password = password.text;
                              final user = await db.getUser(email);
                              if (user != null && user.password == Password) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              } else {
                                Utils().toastMessage(
                                    'email & password are incorrect');
                              }
                            }
                          });
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ResuableRow(
                        title: 'signup',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()));
                        })
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
