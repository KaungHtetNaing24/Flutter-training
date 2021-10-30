import 'package:flutter/material.dart';


class Caculator extends StatefulWidget {
  const Caculator({ Key? key }) : super(key: key);

  @override
  _CaculatorState createState() => _CaculatorState();
}

class _CaculatorState extends State<Caculator> {
  String output = "0";
  String _output = "0";

  operation(String btntext){
      _output = btntext;
      setState(() {
        output = int.parse(_output).toString();
      });
  }

  Widget button(String btntext){
    return Expanded(
      child: RawMaterialButton(
      shape: Border.all(color: Colors.blueGrey),
      splashColor: Colors.blueGrey,
      fillColor: Colors.grey,
      child: Text(
        btntext,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),
        ),
      padding: const EdgeInsets.all(30.0),
      onPressed: (){
        operation(btntext);
      }
      )
     );
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Assignment"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    output,
                    style:const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w600
                    )
                    ),
                )
                ),
              Row(
                children: [
                  button('1'),
                  button('2'),
                  button('3'),
                  
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  button('4'),
                  button('5'),
                  button('6'),
                  
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  button('7'),
                  button('8'),
                  button('9'),
                  
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}