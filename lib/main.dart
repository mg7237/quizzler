import 'package:flutter/material.dart';
import 'package:quizzler/QuestionBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBank questionBank = QuestionBank();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNo = 0;
  List<Icon> iconList = [];

  void evaluateAnswer(bool clickTrueOrFalse) {
    setState(() {
      if (questionNo == 0) {
        iconList = [];
      }

      if ((questionBank.getAnswer(questionNo) == false) &&
          (clickTrueOrFalse == false)) {
        iconList.add(Icon(Icons.check, color: Colors.green));
      } else if ((questionBank.getAnswer(questionNo) == true) &&
          (clickTrueOrFalse == true)) {
        iconList.add(Icon(Icons.check, color: Colors.green));
      } else {
        iconList.add(Icon(Icons.close, color: Colors.red));
      }
    });
    questionNo++;
    if (questionNo == 13) {
      Alert(context: context, title: "Manish Magic", desc: "Manish is awesome.")
          .show();
      questionNo = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestion(questionNo),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                evaluateAnswer(true);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                evaluateAnswer(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: iconList)),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
