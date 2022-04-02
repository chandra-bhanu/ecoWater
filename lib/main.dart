import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  void answerQuestion(){
    print('Answer Choosen!');
  }

  @override
  Widget build(BuildContext context) {
    var questions=[
                  'What\'s your favourite color',
                  'What is your favourite animal?'
                ];
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: Text('ecoWater Jars'),),
        body: Column(
              children: [
                Text(questions.elementAt(0),),
                ElevatedButton(child: Text('Answered 1'),onPressed: () =>  print('Answered 1 choosen'),),
                ElevatedButton(child: Text('Answered 2'),onPressed: answerQuestion,),
                ElevatedButton(child: Text('Answered 3'),onPressed: () {
                  print('Answered 3 choosen');
                },),
              ],
        ),
      ),
    );
  }

}
