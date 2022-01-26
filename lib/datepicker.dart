import 'dart:ui';

import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'datepicker',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _dateTime = DateTime.now();
  String _output = "";

  operation(){
      showDatePicker(
      context: context, 
      initialDate: DateTime(2000), 
      firstDate: DateTime(1910), 
      lastDate: DateTime(2222)
        ).then((date){
        setState(() {
        _dateTime = date!;
            if(_dateTime.day< 16 && _dateTime.month == 4){
            _output = (_dateTime.year - 639).toString();
            }else if(_dateTime.month < 4){
            _output = (_dateTime.year - 639).toString();
            }
            else{
            _output = (_dateTime.year - 638).toString();
            }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
          title: const Text('Date Picker'),
          backgroundColor: Colors.redAccent,
        ),
        body: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top:350),
                child: const Text("Sayar Annt Min Nyo",style: TextStyle(color: Colors.white,fontSize: 30),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  border: Border.all(
                  color: Colors.white, //                   <--- border color
                  width: 3.0,
                  ),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Please Choose your birthday to see your fate.",style: TextStyle(color: Colors.white),),
                ElevatedButton(
                onPressed: (){
                  operation();
                }, 
                child: const Text('Pick a date'),
                    style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    fixedSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
                ),
                Text(_dateTime.weekday.toString(),style: const TextStyle(color: Colors.white),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text(_dateTime == null ? 'Nothing has been picked yet' : " Your Myanmar date is $_output" ,style: const TextStyle(fontSize: 25,color: Colors.white)),
                        const SizedBox(
                        height: 5,
                        ),
                      
                  ],
                  ),
                ],
              ),
          ),
            ),
          ],
          
        ),
    );
  }
}