import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tp70/entities/matiere.dart';
import 'package:tp70/service/matiereservice.dart';
import 'package:tp70/template/dialog/matieredialog.dart';
import 'package:tp70/template/navbar.dart';

class MatiereScreen extends StatefulWidget {
  @override
  _MatiereScreenState createState() => _MatiereScreenState();
}

Matiere? selectedMatiere;

class _MatiereScreenState extends State<MatiereScreen> {
  refresh() {
    setState(() {});
  }

  Future<List<Matiere>> getAllMatieres() async {
    return await MatiereService.getAllMatieres();
  }

  Future<void> deleteMatiere(int matiereId) async {
    await MatiereService.deleteMatiere(matiereId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar('Matieres'),
      body: FutureBuilder(
        future: getAllMatieres(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Matiere>>? snapshot) {
          if (snapshot != null && snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  key: Key(snapshot.data![index].matiereId.toString()),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MatiereDialog(
                                notifyParent: refresh,
                                matiere: Matiere.withId(
                                  snapshot.data![index].matiereId,
                                  snapshot.data![index].matiereName,
                                ),
                                selectedMatiere:
                                    selectedMatiere, // Add this line
                              );
                            },
                          );
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () async {
                      await deleteMatiere(snapshot.data![index].matiereId!);
                      setState(() {
                        snapshot.data!.removeAt(index);
                      });
                    }),
                    children: [Container()],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Matiere : "),
                                Text(
                                  snapshot.data![index].matiereName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return MatiereDialog(
                notifyParent: refresh,
                selectedMatiere: selectedMatiere,
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
