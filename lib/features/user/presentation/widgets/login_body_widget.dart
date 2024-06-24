import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import '../../../../cores/app/theme/style.dart';
import 'phone_input.dart';

class LoginBodyWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final Country selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final VoidCallback onSubmitVerifyPhoneNumber;

  const LoginBodyWidget({
    super.key,
    required this.phoneController,
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.onSubmitVerifyPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Verify your phone number",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: tabColor),
              ),
            ),
            const Text(
              "WhatsApp Clone will send you SMS message (carrier charges may apply) to verify your phone number. Enter the country code and phone number",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 30),
            PhoneInput(
              phoneController: phoneController,
              selectedCountry: selectedCountry,
              onCountrySelected: onCountrySelected,
            ),
            GestureDetector(
              onTap: onSubmitVerifyPhoneNumber,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
