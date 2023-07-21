import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theunion/components/custom_button.dart';
import 'package:theunion/components/custom_input_field.dart';
import 'package:theunion/models/user.dart';
import 'package:theunion/network/api.dart';
import 'package:theunion/pages/Authentication/Components/validators.dart';
import 'package:theunion/pages/Home/home_page.dart';
import 'package:theunion/resources/app_config.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/common.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String username = "";
  String password = "";
  bool isPasswordVisible = true;
  bool isLoading = false;

  _signInBtnClick(context) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        UserResponse user = await API().signin(username, password);
        debugPrint("$user");
        prefs.setString('userid', user.data!.userid);
        prefs.setString('token', user.data!.token);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } catch (e) {
        showToast(e.toString(), ERROR_COLOR, WEB_ERROR_COLOR);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: INPUT_COLOR),
    );

    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.65,
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/images/$LOGO",
                      ),
                    ),
                  ),
                  const SizedBox(height: SIZED_BOX_HEIGHT),
                  Container(
                    width: size.width * 0.85,
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: [
                        CustomInputField(
                            hintText: 'Username',
                            floatLabel: true,
                            onChanged: (val) {
                              setState(() {
                                username = val;
                              });
                            },
                            validator: (val) =>
                                Validator.validateUsername(val!),
                            controller: _usernameController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isPasswordVisible,
                          onFieldSubmitted: (val){
                            if (_key.currentState?.validate() == true) {
                              _signInBtnClick(context);
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          cursorColor: INPUT_COLOR,
                          style: const TextStyle(color: INPUT_COLOR),
                          validator: (val) => Validator.validatePassword(val!),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding:
                                  const EdgeInsets.all(MARGIN_MEDIUM_4),
                              labelText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: MARGIN_MEDIUM_2),
                                  child: isPasswordVisible
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: INPUT_COLOR,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: INPUT_COLOR,
                                        ),
                                ),
                              ),
                              hintStyle: const TextStyle(color: INPUT_COLOR),
                              focusedBorder: border,
                              enabledBorder: border,
                              border: border,
                              disabledBorder: border,
                              labelStyle: const TextStyle(color: INPUT_COLOR),
                              floatingLabelStyle:
                                  const TextStyle(color: INPUT_COLOR)),
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomButton(
                          text: "Sign In",
                          loading: isLoading,
                          press: () {
                            if (_key.currentState?.validate() == true) {
                              _signInBtnClick(context);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
