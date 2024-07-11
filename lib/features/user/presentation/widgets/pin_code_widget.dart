
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../../../../cores/app/theme/style.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController otpController;
  const PinCodeWidget({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          PinCodeFields(
            controller: otpController,
            length: 6,
            activeBorderColor: tabColor,
            onComplete: (String pinCode) {},
          ),
          const Text("Enter your 6 digit code")
        ],
      ),
    );
  }
}
