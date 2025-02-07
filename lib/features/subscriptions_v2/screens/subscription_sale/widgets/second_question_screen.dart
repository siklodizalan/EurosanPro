import 'package:eurosanpro/features/subscriptions_v2/screens/subscription_sale/widgets/question_screen.dart';
import 'package:flutter/material.dart';

class SecondQuestionScreen extends StatelessWidget {
  const SecondQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreen(
      question: "Do you have a standard plus product?",
      onAnswerSelected: (answer) {
        print("Second Question Answer: $answer");
      },
      nextRoute: '/pdfUpload',
    );
  }
}
