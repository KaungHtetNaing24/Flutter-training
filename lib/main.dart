import 'package:flutter/material.dart';
// import 'package:flutter_app_day10/assignment.dart';
// import 'package:flutter_app_day10/assignment2.dart';
// import 'package:flutter_app_day10/datepicker.dart';
import 'package:flutter_app_day10/student_data.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  // runApp(const MyApp());
  // runApp(const Caculator());
  // runApp(const Textfield());
  // runApp(const DatePicker());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan)
    ),
    home: const StudentData(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alert dialog',
        home: AlertWidget(),
    );
  }
}

class  AlertWidget extends StatelessWidget {
  const AlertWidget ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Form"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Kaung Htet"), 
                accountEmail: const Text("khn@gmail.com"),
                currentAccountPicture: Container(
                 height: 60,
                 width: 60,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(100),
                   image: const DecorationImage(image: AssetImage("assets/profile.png"),fit: BoxFit.cover)
                  ),
                ),
                ),
                const ListTile(
                  leading: Icon(Icons.home) ,
                  title: Text("Home"),
                ),
                const ListTile(
                  leading: Icon(Icons.settings) ,
                  title: Text("Setting"),
                ),
                const ListTile(
                  leading: Icon(Icons.local_grocery_store) ,
                  title: Text("Store"),
                )
            ],
          ),
        ),
        
        // body: const Forms(),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
            child: Center(
              child: Container(
                height: 200,
                width: 300,
                child: Card(
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: ListTile(
                          leading: Icon(Icons.person,size: 40,color: Colors.blue,),
                          title: Text("Kaung Htet Naing",style: TextStyle(fontSize: 20,color: Colors.black),),
                          subtitle: Text("COO",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                        ),
                      ),
                      ButtonBar(
                        children: [
                            RaisedButton(
                                child: const Text("Simple alert"),
                                color: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                ),
                                textColor: Colors.white,
                                splashColor: Colors.blue,
                                onPressed: (){
                                  alertdialogwidget(context);
                                },
                            ),
                            RaisedButton(
                                child: const Text("Selection alert"),
                                color: Colors.lightBlueAccent,
                                onPressed: () async{
                                   final selectopt option = await selectionalertdialogwidget(context);
                                   // ignore: avoid_print
                                   print(option);
                                },
                                textColor: Colors.white,
                                splashColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          
        ),
    );
  }
}


alertdialogwidget(BuildContext context){

  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: const Text("Basic"),
      content: const Text("This is for notification purpose"),
      actions: [
        ElevatedButton(
          child: const Text("OK"),
          onPressed: (){
            Navigator.of(context).pop();
          }
          )
      ],
    );
  });
}


enum selectopt {C,java,python,php}
selectionalertdialogwidget(BuildContext context) async{

  return showDialog<selectopt>(
    context: context, 
    barrierDismissible: true,
    builder: (BuildContext context){
      return SimpleDialog(
        title: const Text("Choose one"),
        children: [
          SimpleDialogOption(
            onPressed: (){
              Navigator.pop(context,selectopt.C);
              },
              child: const Text("C"),
          ),
          SimpleDialogOption(
            onPressed: (){
              Navigator.pop(context,selectopt.java);
              },
              child: const Text("Java"),
          ),
          SimpleDialogOption(
            onPressed: (){
              Navigator.pop(context,selectopt.python);
              },
              child: const Text("Python"),
          ),
          SimpleDialogOption(
            onPressed: (){
              Navigator.pop(context,selectopt.php);
              },
              child: const Text("PHP"),
          ),
        ],
      );
    });
}


// class Forms extends StatefulWidget {
//   const Forms({ Key? key }) : super(key: key);

//   @override
//   _FormsState createState() => _FormsState();
// }

// class _FormsState extends State<Forms> {
//   final keys = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {

//     return Form(
//       key: keys,
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//                 Padding(
//                   padding: const EdgeInsets.all(28.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           Image.asset("assets/profile.png",width: 200,),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: "Enter your name",
//                   labelText: "Name",
//                   icon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: "Enter your Password",
//                   labelText: "Password",
//                   icon: Icon(Icons.lock),
//                 ),
//                 validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Validate returns true if the form is valid, or false otherwise.
//                     if (keys.currentState!.validate()) {
//                       // If the form is valid, display a snackbar. In the real world,
//                       // you'd often call a server or save the information in a database.
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Processing Data')),
//                       );
//                     }
//                   },
//                   child: const Text('Login'),
//                 ),
//               ),
//             ],
//         ),
//       )
//       );

//   }
// }