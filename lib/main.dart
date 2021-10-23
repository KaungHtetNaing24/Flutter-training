import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App 10',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Form")
        ),
        body: const Forms(),
      ),
    );
  }
}

class Forms extends StatefulWidget {
  const Forms({ Key? key }) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: keys,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset("assets/profile.png",width: 200,),
                        ],
                      )
                    ],
                  ),
                ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your Password",
                  labelText: "Password",
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (keys.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
        ),
      )
      );

  }
}