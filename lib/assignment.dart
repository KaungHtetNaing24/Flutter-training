import 'package:flutter/material.dart';


class Caculator extends StatefulWidget {
  const Caculator({ Key? key }) : super(key: key);

  @override
  _CaculatorState createState() => _CaculatorState();
}

class _CaculatorState extends State<Caculator> {
  String output = "Start with 0";
  String _output = "0";
  String output1 = "0";

  operation(String btntext){
      _output = btntext;
      setState(() {
        output1 = int.parse(_output).toString();
        output = "This is ' $output1 '";
      });
  }

  Widget button(String btntext){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
        child: Text(
          btntext,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),
          ),
        // padding: const EdgeInsets.all(30.0),
        onPressed: (){
          operation(btntext);
        }
        ),
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
          
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Text(
                  output,
                  style:const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600
                  )
                  ),
              )
              ),
          ],
        ),
      ),
    );
  }
}