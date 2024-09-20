import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class SideBySideImages extends StatelessWidget {
  const SideBySideImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: TSizes.sm),
          child:
          SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Image.asset(
                  TImages.eurosanDoorLogo,
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: TSizes.sm),
          child:
          SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Image.asset(
                  TImages.eurosanProLogo,
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
      ],
    );
  }
}