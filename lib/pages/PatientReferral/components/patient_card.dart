import 'package:flutter/material.dart';
import 'package:theunion/models/patient.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientCard({Key? key, required this.patient, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
        margin: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
        decoration: const BoxDecoration(
          
          color: LIST_TITLE_COLOR,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: CARD_COLOR,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/patient.png',
                    width: 45,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [  
                    Container(
                      margin: EdgeInsets.only(bottom: MARGIN_SMALL),
                      child: Text(
                        patient.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: TEXT_REGULAR_3X,
                            color: PRIMARY_TEXT_COLOR),
                      ),
                    ),
                    Text(
                      "${patient.sex} | ${patient.age}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: TEXT_REGULAR,
                          color: SECONDARY_TEXT_COLOR),
                    ),
                    Text(
                      patient.referDate,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: TEXT_REGULAR,
                          color: SECONDARY_TEXT_COLOR),
                    ),
                    Text(
                      "${patient.township} | ${patient.address} ",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: TEXT_REGULAR,
                          color: SECONDARY_TEXT_COLOR),
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: TEXT_REGULAR,
                              color: SECONDARY_TEXT_COLOR),
                          children: [
                            const TextSpan(text: "From "),
                            TextSpan(
                                text: patient.referFrom,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(text: " to "),
                            TextSpan(
                                text: patient.referTo,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(bottom: MARGIN_SMALL),
                      child: Text(
                        patient.signAndSymptom,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: TEXT_REGULAR,
                            color: SECONDARY_TEXT_COLOR),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
