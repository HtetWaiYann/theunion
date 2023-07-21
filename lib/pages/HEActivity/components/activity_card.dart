import 'package:flutter/material.dart';
import 'package:theunion/models/activity.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onTap;
  const ActivityCard({super.key, required this.activity, required this.onTap});

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
                    'assets/images/activity.png',
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
                        activity.date,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: TEXT_REGULAR_3X,
                            color: PRIMARY_TEXT_COLOR),
                      ),
                    ),
                    Text(
                      activity.address,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: TEXT_REGULAR,
                          color: SECONDARY_TEXT_COLOR),
                    ),
                    Text(
                      activity.volunteer,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: TEXT_REGULAR,
                          color: SECONDARY_TEXT_COLOR),
                    ),
                    Text(
                      activity.helist,
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
                            const TextSpan(text: "Male - "),
                            TextSpan(
                                text: activity.male,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(text: " | Female - "),
                            TextSpan(
                                text: activity.female,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ]),
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
