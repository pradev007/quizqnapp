import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReadData extends StatelessWidget {
  const ReadData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        centerTitle: true,
      ),
      backgroundColor: Colors.amber,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('questions').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        startActionPane:
                            ActionPane(motion: const DrawerMotion(), children: [
                          SlidableAction(
                            onPressed: (constext) {
                              deleteQn(document.id);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Colors.greenAccent,
                            icon: Icons.edit_document,
                            label: 'Edit',
                          )
                        ]),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            // document.id,
                            document['qn'],
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['correct']),
                              Text(document['incorrect1']),
                              Text(document['incorrect2']),
                              Text(document['incorrect3']),
                            ],
                          ),
                        ),
                      ),

                      // child: Text(document['qn']),
                    ),
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}

deleteQn(String documentId) {
  CollectionReference collRef =
      FirebaseFirestore.instance.collection('questions');
  collRef.doc(documentId).delete();
}
