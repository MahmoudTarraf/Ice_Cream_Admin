import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';

void showSuccess(BuildContext context, String thisTitle, String thisSubtitle) {
  AchievementView(
    alignment: Alignment.center,
    color: Colors.green,
    title: thisTitle,
    subTitle: '$thisSubtitle',
    textStyleSubTitle: const TextStyle(
      fontSize: 12,
    ),
    isCircle: true,
    listener: (status) {
      print(status);
    },
    onTap: () {
      FocusScope.of(context).unfocus();
    },
  ).show(context);
}

void showError(BuildContext context, String thisTitle, String thisSubtitle) {
  AchievementView(
    alignment: Alignment.center,
    color: Colors.red,
    title: thisTitle,
    subTitle: '$thisSubtitle !',
    textStyleSubTitle: const TextStyle(
      fontSize: 12,
    ),
    isCircle: true,
    listener: (status) {
      print(status);
    },
    onTap: () {
      FocusScope.of(context).unfocus();
    },
  ).show(context);
}
