import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  const Textfield({ Key? key }) : super(key: key);

  @override
  _TextfieldState createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  
  int _date = 0;
  int output = 0;
  bool _validate = false;
  final _dateCon = TextEditingController();

  @override
  void dispose() {
    _dateCon.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment2',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Textfield Demo'),
        ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Your Myanmar date is $output',
                      style: const TextStyle(
                      fontSize: 20,fontWeight: 
                      FontWeight.w500),
                      ),
                ),
              ),
              TextField(
                controller: _dateCon,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your birth date",
                  errorText: _validate ? 'Date can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                    _dateCon.text.isEmpty ? _validate = true : _validate = false;
                    _date = int.tryParse(_dateCon.text)?? 638;
                    output = _date - 638;
                  });
                  }, 
                  child: const Text('Submit')
                ),
              ),
            ],
          ),
        ),
      )
      ),
      );
    }
}