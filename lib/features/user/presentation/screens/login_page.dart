import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/features/user/presentation/cubit/user/user_cubit.dart';
import '../../../../cores/app/const/app_const.dart';
import '../../../../cores/app/home/home_page.dart';
import '../../../../cores/app/theme/style.dart';
import '../../../call/presentation/cubits/my_call_history/my_call_history_cubit.dart';
import '../../../status/presentation/cubit/status/status_cubit.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/credential/credential_cubit.dart';
import '../cubit/get_single_user/get_single_user_cubit.dart';
import '../widgets/login_body_widget.dart';
import 'inital_profile_submit_page.dart';
import 'otp_page.dart';
import 'package:whats_app_clone/main_injection_container.dart' as di;
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  static Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode("20");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = "";

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialListenerState) {
        if (credentialListenerState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (credentialListenerState is CredentialFailure) {
          toast("Something went wrong");
        }
      },
      builder: (context, credentialBuilderState) {
        if (credentialBuilderState is CredentialLoading) {
          return const Center(child: CircularProgressIndicator(color: tabColor));
        }
        if (credentialBuilderState is CredentialPhoneAuthSmsCodeReceived) {
          return const OtpPage();
        }
        if (credentialBuilderState is CredentialPhoneAuthProfileInfo) {
          return InitialProfileSubmitPage(phoneNumber: _phoneNumber);
        }
        if (credentialBuilderState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => di.sl<GetSingleUserCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<MyCallHistoryCubit>()
                      ..getMyCallHistory(uid: authState.uid),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<UserCubit>()
                  ),
                  BlocProvider(
                      create: (context) => di.sl<StatusCubit>()
                  ),
                ],child: HomePage(uid: authState.uid));
              }
              return LoginBodyWidget(
                phoneController: _phoneController,
                selectedCountry: _selectedFilteredDialogCountry,
                onCountrySelected: (Country country) {
                  setState(() {
                    _selectedFilteredDialogCountry = country;
                    _countryCode = country.phoneCode;
                  });
                },
                onSubmitVerifyPhoneNumber: _submitVerifyPhoneNumber,
              );
            },
          );
        }
        return LoginBodyWidget(
          phoneController: _phoneController,
          selectedCountry: _selectedFilteredDialogCountry,
          onCountrySelected: (Country country) {
            setState(() {
              _selectedFilteredDialogCountry = country;
              _countryCode = country.phoneCode;
            });
          },
          onSubmitVerifyPhoneNumber: _submitVerifyPhoneNumber,
        );
      },
    );
  }

  void _submitVerifyPhoneNumber() {
    if (_phoneController.text.isNotEmpty) {
      _phoneNumber = "+$_countryCode${_phoneController.text}";
      BlocProvider.of<CredentialCubit>(context).submitVerifyPhoneNumber(
        phoneNumber: _phoneNumber,
      );
    } else {
      toast("Enter your phone number");
    }
  }
}
