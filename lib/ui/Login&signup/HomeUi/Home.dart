import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_sqflite/DBHelper/DBNote.dart';
import 'package:flutter_notes_app_with_sqflite/notes.dart/Notes.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/notesAdd.dart';
import 'package:flutter_notes_app_with_sqflite/ui/Login&signup/HomeUi/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final editingController = TextEditingController();
  final descupdate = TextEditingController();
  DBNotes? db;
  late Future<List<Notes>> noteslist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DBNotes();
    load();
  }

  load() {
    setState(() {
      noteslist = db!.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('HomeScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: noteslist,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Notes>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child: Icon(Icons.delete_forever),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  db!.deleteData(snapshot.data![index].id!);
                                  noteslist = db!.getData();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: ListTile(
                                title: Text(
                                    snapshot.data![index].title.toString()),
                                subtitle: Text(snapshot.data![index].description
                                    .toString()),
                                trailing: PopupMenuButton(
                                    icon: Icon(Icons.more_vert),
                                    itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                              child: ListTile(
                                            title: Text('Edit'),
                                            trailing: Icon(Icons.edit),
                                            onTap: () {
                                              setState(() {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              title: TextField(
                                                                controller:
                                                                    editingController,
                                                                decoration: InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.0)))),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'Cancel')),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      db!.updateData(Notes(id: snapshot.data![index].id, title: snapshot.data![index].title, description: editingController.text.toString())).then(
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          Utils()
                                                                              .toastMessage("Data Updated Successfully");
                                                                          noteslist =
                                                                              load();
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                      }).onError(
                                                                          (error,
                                                                              stackTrace) {
                                                                        Utils().toastMessage(
                                                                            error.toString());
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                        'Update')),
                                                              ],
                                                            ));
                                              });
                                            },
                                          )),
                                        ]),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddData()));
          }),
    );
  }
}
