import 'package:flutter/material.dart';
import 'package:theunion/pages/Authentication/signin_page.dart';
import 'package:theunion/pages/Home/home_page.dart';
import 'package:theunion/resources/app_config.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/functions_provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _functionsProvider = FunctionsProvider();

  @override
  void initState() {
    super.initState();

    // check user already logged in
    checkLoggedIn();
  }

  checkLoggedIn() async {
    String token = await _functionsProvider.getToken();
    bool isLoggedIn = token != '';
    await Future.delayed(const Duration(seconds: 1));
    _navigateToPage(isLoggedIn);
  }

  Future _navigateToPage(bool isLoggedIn) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return isLoggedIn ? HomePage() : SignIn();
      // return isLoggedIn ? HomePage() : Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Container(
              width: size.width * 0.65,
              constraints: const BoxConstraints(maxWidth: 300),
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/$LOGO",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MARGIN_XLARGE),
              child: Text(
                VERSION,
                style: const TextStyle(
                    color: INPUT_COLOR,
                    fontSize: TEXT_SMALL,
                    decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}
