import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_day10/profile.dart';
import 'package:flutter_app_day10/student_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Username"), 
              accountEmail: Text(user.email!)
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title:const Text('Profile'),
              onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Profile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Add Student'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const StudentData()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title:const Text('Log out'),
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("MyStudents").snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child:CircularProgressIndicator(),
                );
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView(
                    children: documents.map((document) {
                      return ListTile(
                        title:Text(document["studentName"]),
                        subtitle: Text(document["studentID"]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Infomation(value:document["studentName"])));
                        }
                      );
                    }).toList()
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Infomation extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var value;
  Infomation({ Key? key,this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("MyStudents").doc(value).collection("projects").
            snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child:CircularProgressIndicator(),
                );
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView(
                    children: documents.map((document) {
                      return ListTile(
                        title:Text(document["name"]),
                        subtitle: Text(document["platform"]),
                      );
                    }).toList()
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}