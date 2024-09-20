import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/image_strings.dart';
import 'package:eurosanpro/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCustomHeader extends StatelessWidget {
  const TCustomHeader({
    super.key,
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Image(
            height: 60,
            image: AssetImage(dark ? TImages.eurosanProLogo : TImages.eurosanProLogoDark)
        ),
        Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TColors.primary)
        )
      ],
    );
  }
}
