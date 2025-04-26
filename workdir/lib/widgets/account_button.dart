// lib/widgets/account_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/theme/theme.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({
    Key? key,
    required this.size,
    this.onTap,
    this.destination = '/connectedApps',
    this.imagePath = 'assets/images/placeholders/profilePicPlaceholder.jpeg',
  }) : super(key: key);

  final double size;
  final VoidCallback? onTap;
  final String destination;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      if (onTap != null) {
        onTap!();
      } else {
        Navigator.pushNamed(context, destination);
      }
    }

    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
        width: size,
        height: size,
        child: InkWell(
          onTap: handleTap,
        ),
      ),
    );
  }
}
