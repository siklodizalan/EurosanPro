import 'package:eurosanpro/features/authentication/controllers/user_controller.dart';
import 'package:eurosanpro/features/contract/controllers/contract_controller.dart';
import 'package:eurosanpro/utils/constraints/colors.dart';
import 'package:eurosanpro/utils/constraints/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenMiddlePart extends StatelessWidget {
  const HomeScreenMiddlePart({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final contractController = ContractController.instance;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: Text(
                            "${userController.user.value.firstName} ${userController.user.value.lastName}",
                            style: const TextStyle(color: Colors.white, fontSize: TSizes.fontSizeLg * 2, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.star_fill, color: TColors.primary, size: 30),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data: ${contractController.contract.value.contractDate}',
                              style: const TextStyle(color: Colors.white, fontSize: TSizes.fontSizeLg * 0.6),
                            ),
                            Text(
                              'Nr. de contact: ${contractController.contract.value.contractNumber}',
                              style: const TextStyle(color: Colors.white, fontSize: TSizes.fontSizeLg * 0.6),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // const NumberWithText(number: 360),
        ],
      ),
    );
  }
}
