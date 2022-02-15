import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ImagePicker image = ImagePicker();
  String url = "";
  File? file;
  getImage()async{
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  uploadFile()async{
    var imageFile = FirebaseStorage.instance.ref().child("path").child("/.jpg");
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    //for downloading
    url = await snapshot.ref.getDownloadURL();
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      "imageUrl" : url
    },SetOptions(merge: true)
    ).then((value) => print("updateed"));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
            onTap: (){
              getImage();
            },
            child: CircleAvatar(
              radius: 80,
              backgroundImage: file==null
                  ? const AssetImage("")
                  : FileImage(File(file!.path)) as ImageProvider,
            ),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.brown),
            cursorColor: Colors.brown,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Username',labelStyle: TextStyle(color: Colors.brown)),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value)=>
            value != null && value.length < 6
              ? 'Enter min 6 characters'
              :null,
          ),
          ElevatedButton(
            onPressed: (){
              uploadFile();
            }, 
            child: const Text('Upload'))
        ],
        ),
      ),
    );
  }
}