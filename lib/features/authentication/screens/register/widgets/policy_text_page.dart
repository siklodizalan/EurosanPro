import 'package:eurosanpro/common/widgets/appbar/appbar.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';

class PolicyTextPage extends StatelessWidget {
  final String titleText;
  final String policyText;
  final bool appBarShowBackArrow;

  const PolicyTextPage({
    super.key,
    required this.titleText,
    required this.policyText,
    this.appBarShowBackArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      TAppBar(showBackArrow: appBarShowBackArrow, title: Text(titleText)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Text(policyText)
        ),
      ),
    );
  }
}
