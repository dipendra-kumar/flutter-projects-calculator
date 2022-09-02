import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion ='';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '+/-',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.black,),

      backgroundColor: Colors.black,

      body: Column(

        children: [

          Expanded(
          flex: 1,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white12,
        ),
        margin: EdgeInsets.all(10),

      child: Padding(

        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(20),
              alignment:Alignment.bottomRight,
              // color: Colors.grey[100],
              child:Text(userQuestion, style: TextStyle(fontSize: 30, color: Colors.white),)),
          Container(
              padding: EdgeInsets.all(20),
              alignment:Alignment.centerRight,
              child:Text(userAnswer, style: TextStyle(fontSize: 36, color: Colors.white),),
          )
        ],

                ),
      ),
            ),
          ),
          Expanded(
            flex: 2,

            child: Container(
              // color: Colors.grey[500],
             margin: EdgeInsets.all(10),

              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    //clear button
                    if (index == 0) {
                      return MyButton(buttonTapped: (){
                        setState(() {
                          userQuestion ='';
                          userAnswer = '';
                        });
                      },
                        buttonText: buttons[index],
                        color: Colors.white10 ,
                        textColor: Colors.redAccent,
                      );

                    }
                    //delete button
                    else if (index == 1) {
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                            userQuestion = userQuestion.substring(0, userQuestion.length -1);
                          });

                        },

                        buttonText: buttons[index],
                        color: Colors.white10,
                        textColor: Colors.redAccent,
                      );
                    }
                    //DEL BUTTON
                    else if(index ==buttons.length -1){
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                            equalPressed();
                          });

                        },

                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    }
                    else if(index == buttons.length-4){
                      return MyButton(
                          buttonTapped: (){
                        setState(() {
                          addNegetive();
                        });

                      },

                    buttonText: buttons[index],
                    color: Colors.white10,
                    textColor: Colors.white,
                    );
                    }

                    else {
                      return MyButton(buttonTapped: (){
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.white12
                            : Colors.white10,
                        textColor: isOperator(buttons[index])
                            ? Colors.deepPurple[200]
                            : Colors.white,
                      );
                    }
                  }),
    ),
          ),
        ],
      ),
    );
  }





  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '+' || x == '-' || x == '=' || x == '*') {
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion  = userQuestion;
    Parser  p = Parser();
    Expression exp  =p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    num eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }

  void addNegetive(){
    String res;
    if(userQuestion[0] != '-'){
      res = '-$userQuestion';
    }
    else{
      res = userQuestion.substring(1);
    }
    userQuestion = res;

  }
}
