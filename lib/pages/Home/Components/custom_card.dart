import 'package:flutter/material.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String text;

  final String img;
  final VoidCallback onTap;

  const CustomCard(
      {Key? key,
      required this.title,
      required this.text,
      required this.img,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(MARGIN_MEDIUM_3),
        decoration: const BoxDecoration(
          color: LIST_TITLE_COLOR,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                    child: Image.asset(img, width: 45),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: MARGIN_SMALL),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: TEXT_REGULAR_3X,
                                color: PRIMARY_TEXT_COLOR),
                          ),
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              fontSize: TEXT_REGULAR,
                              color: SECONDARY_TEXT_COLOR),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Icon(Icons.arrow_forward)],)
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
