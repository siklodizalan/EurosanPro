import 'package:eurosanpro/features/subscriptions/screens/widgets/logo.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final String question;
  final Function(bool) onAnswerSelected;
  final String nextRoute;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.nextRoute,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with SingleTickerProviderStateMixin {
  String? packageIdentifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (packageIdentifier == null) {  // Only set this once
      final args = ModalRoute.of(context)!.settings.arguments as Map?;
      packageIdentifier = args?['packageIdentifier'] as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Orange fade-ins on the sides using a gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Colors.transparent,
                    TColors.primary,
                  ],
                ),
              ),
            ),
          ),
          
          // Centered logo at the top of the screen
          

          // The question text and buttons
          Center(
            child:
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Logo(imagePath: TImages.eurosanProLogo),
                  const SizedBox(height: 50),

                  Text(
                    widget.question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.onAnswerSelected(true);
                          Navigator.pushNamed(
                            context,
                            widget.nextRoute,
                            arguments: {'packageIdentifier': packageIdentifier},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: const Text("Yes"),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          widget.onAnswerSelected(false);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: const Text("No"),
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
