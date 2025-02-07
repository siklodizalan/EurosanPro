import 'package:eurosanpro/features/subscriptions_v2/screens/subscription_sale/widgets/question_screen.dart';
import 'package:flutter/material.dart';

class FirstQuestionScreen extends StatelessWidget {
  const FirstQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreen(
      question: "Are you an Eurosandoor customer?",
      onAnswerSelected: (answer) {
        print("First Question Answer: $answer");
      },
      nextRoute: '/secondQuestion',
    );
  }
}
