import 'package:eurosanpro/common/widgets/number_text.dart';
import 'package:eurosanpro/data/repositories/authentication/authentication_repository.dart';
import 'package:eurosanpro/features/authentication/controllers/user_controller.dart';
import 'package:eurosanpro/features/contract_upload/controllers/contract_controller.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10),
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
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text(
                            userController.user.value.name,
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
                        Icon(CupertinoIcons.star_fill, color: TColors.primary, size: 30),
                        SizedBox(width: 8),
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
                TextButton(
                  child: Text('LOG OUT', style: TextStyle(color: TColors.primary)),
                  onPressed: () => AuthenticationRepository.instance.logout(),
                ),
              ],
            ),
          ),
          NumberWithText(number: 360),
        ],
      ),
    );
  }
}
