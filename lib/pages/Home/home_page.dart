import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theunion/pages/Authentication/signin_page.dart';
import 'package:theunion/pages/HEActivity/he_activity.dart';
import 'package:theunion/pages/Home/Components/custom_card.dart';
import 'package:theunion/pages/PatientReferral/patient_referral.dart';
import 'package:theunion/resources/app_config.dart';
import 'package:theunion/resources/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _navigateToPage(Widget page) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(APP_NAME),
          actions: [
            PopupMenuButton(
              onSelected: (result) {
                if (result == 0) {
                  logout();
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Sign Out"),
                  ),
                ];
              },
            )
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                CustomCard(
                    title: 'Patient Referral',
                    text: "Click to view the patient referral lists and create new ones.",
                    img: "assets/images/patient_referral.png",
                    onTap: () => {_navigateToPage(const PatientReferral())}),
                const SizedBox(
                  height: FORM_BOX_HEIGHT,
                ),
                CustomCard(
                    title: 'HE Activity',
                    text: "Click to view the HE Activiy list and also create new ones.",
                    img: "assets/images/medical-record.png",
                    onTap: () => {_navigateToPage(const HEActivity())})
              ]),
            ),
          ),
        ));
  }
}
