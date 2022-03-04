import 'package:flutter/material.dart';

import '../resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;


  const SecondaryActionButton(
      {Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: FightClubColors.darkGreyText)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 40,
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: FightClubColors.darkGreyText,
          ),
        ),
      ),
    );
  }
}
