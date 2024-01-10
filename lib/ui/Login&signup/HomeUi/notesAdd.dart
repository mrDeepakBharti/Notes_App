import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_sqflite/DBHelper/DBNote.dart';
import 'package:flutter_notes_app_with_sqflite/Widgets/RoundedButton.dart';
import 'package:flutter_notes_app_with_sqflite/notes.dart/Notes.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/Home.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/utils.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final titletext = TextEditingController();
  final descriptiontext = TextEditingController();
  final KeyForm = GlobalKey<FormState>();

  final db = DBNotes();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load() {
    db.initDatabase();
  }

  void dispose() {
    super.dispose();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Data Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Form(
                key: KeyForm,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Title';
                        } else {
                          return null;
                        }
                      },
                      controller: titletext,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Add Notes Title Here...',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter some Description';
                        } else {
                          return null;
                        }
                      },
                      controller: descriptiontext,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: 'Add Notes Here..',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RoundButton(
                        title: 'Add',
                        onTap: () {
                          setState(() async {
                            if (KeyForm.currentState!.validate()) {
                              final t = titletext.text;
                              final desc = descriptiontext.text;

                              await db
                                  .insertData(Notes(
                                      title: t.toString(),
                                      description: desc.toString()))
                                  .then((value) => {
                                        Utils().toastMessage(
                                            "Notes Added SuccessFully"),
                                        load()
                                      })
                                  .onError((error, stackTrace) =>
                                      {Utils().toastMessage(error.toString())});

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          });
                        })
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
