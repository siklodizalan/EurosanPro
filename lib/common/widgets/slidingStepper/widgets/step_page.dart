import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class SlidingStepperPage extends StatelessWidget {
  const SlidingStepperPage({
    super.key,
    this.backgroundColor,
    this.backgroundImage,
    required this.mainImage,
    this.labelImage,
    required this.title,
    required this.subTitle,
    this.label,
  });

  final Color? backgroundColor;
  final String? backgroundImage;

  final String mainImage;

  final String? labelImage;
  final String? label;

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (backgroundImage != null)
          Image.asset(
            backgroundImage!,
            fit: BoxFit.cover,
          )
        else if (backgroundColor != null)
          Container(color: backgroundColor),

        Center(
          child: FractionallySizedBox(
            widthFactor: MediaQuery.of(context).size.width > 800 ? 0.7 : 1.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (labelImage != null)
                    Image.asset(
                      labelImage!,
                      height: 50,
                    ),
                  if (label != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        label!,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    mainImage,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
