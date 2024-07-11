import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/features/user/presentation/widgets/dialog_item.dart';
import '../../../../cores/app/const/app_const.dart';
import '../../../../cores/app/theme/style.dart';

class PhoneInput extends StatelessWidget {
  final TextEditingController phoneController;
  final Country selectedCountry;
  final ValueChanged<Country> onCountrySelected;

  const PhoneInput({
    Key? key,
    required this.phoneController,
    required this.selectedCountry,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 2),
          onTap: () => _openFilteredCountryPickerDialog(context),
          title: DialogItem(country: selectedCountry,),
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.50, color: tabColor),
                ),
              ),
              width: 80,
              height: 42,
              alignment: Alignment.center,
              child: Text(selectedCountry.phoneCode),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(top: 1.5),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: tabColor, width: 1.5),
                  ),
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openFilteredCountryPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Theme(
        data: Theme.of(context).copyWith(primaryColor: tabColor),
        child: CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: tabColor,
          searchInputDecoration: const InputDecoration(hintText: "Search"),
          isSearchable: true,
          title: const Text("Select your phone code"),
          onValuePicked: onCountrySelected,
          itemBuilder: (country) => DialogItem(country: country),
        ),
      ),
    );
  }


}
