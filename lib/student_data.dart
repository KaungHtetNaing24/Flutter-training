import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentData extends StatefulWidget {
  const StudentData({ Key? key }) : super(key: key);

  @override
  _StudentDataState createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  late String studentName, studentID, studyProgramID;
  late double studentGPA;

  getStudentName(name){
    studentName = name;
  }

  getStudentID(id){
    studentID = id;
  }

  getStudyProgramID(programID){
    studyProgramID = programID;
  }

  getStudentGPA(gpa){
    studentGPA = double.parse(gpa);
  }

  createData(){
    DocumentReference documentReference = 
      FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

      Map<String, dynamic> students = {
        "studentName" : studentName,
        "studentID" : studentID,
        "studyProgramID" : studyProgramID,
        "studentGPA" : studentGPA
      };
      
      documentReference.set(students).whenComplete(() => print("$studentName created"));
  }

  readData(){
    
  }

  updateData(){
    DocumentReference documentReference = 
      FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

      Map<String, dynamic> students = {
        "studentName" : studentName,
        "studentID" : studentID,
        "studyProgramID" : studyProgramID,
        "studentGPA" : studentGPA
      };
      
      documentReference.set(students).whenComplete(() => print("$studentName updated"));
  }

  deleteData(){
    DocumentReference documentReference = 
      FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

      documentReference.delete().whenComplete(() => print("$studentName deleted"));
  }

    void deleteNestedSubcollections(String id) {
    Future<QuerySnapshot> projects =
        FirebaseFirestore.instance.collection("MyStudents").doc(id).collection("projects").get();
    projects.then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("MyStudents")
            .doc(id)
            .collection("projects")
            .doc(element.id)
            .delete()
            .then((value) => print("success"));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Flutter College"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Name",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,
                  width: 2.0)
                )
              ),
              onChanged: (String name){
                getStudentName(name);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Student ID",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,
                  width: 2.0)
                )
              ),
              onChanged: (String id){
                getStudentID(id);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Study Program ID",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,
                  width: 2.0)
                )
              ),
              onChanged: (String programID){
                getStudyProgramID(programID);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "GPA",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,
                  width: 2.0)
                )
              ),
              onChanged: (String gpa){
                getStudentGPA(gpa);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  createData();
                }, 
                child: const Text("Create"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  fixedSize: const Size(80, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  readData();
                }, 
                child: const Text("Read"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  fixedSize: const Size(80, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  updateData();
                }, 
                child: const Text("Update"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  fixedSize: const Size(80, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  deleteNestedSubcollections(studentName);
                  deleteData();
                }, 
                child: const Text("Delete"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  fixedSize: const Size(80, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            ],
          ),
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(document["studentName"]),
                          Text(document["studentID"]),
                          Text(document["studyProgramID"]),
                          Text(document["studentGPA"].toString())
                        ],
                      );
                    }).toList()
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}