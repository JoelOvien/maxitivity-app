import 'dart:io';

import 'package:ambeego_test/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static Widget getProgressLoader(
      {double? height, double? width, Color? color}) {
    return SizedBox(
      height: (height ?? 15),
      width: (width ?? 15),
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              strokeWidth: 1.5,
              color: color ?? AppColors.brandWhite,
            )
          : Transform.scale(
              scale: 0.7,
              child: CupertinoActivityIndicator(
                color: color ?? AppColors.brandWhite,
              ),
            ),
    );
  }

  static String parseToReadableDate(DateTime date) {
    final formatter = DateFormat('MMMM d, y');
    final formattedDate = formatter.format(date);

    return formattedDate;
  }

  static String parseToReadableTime(DateTime date) {
    final formatter = DateFormat('hh:mm a');
    final formattedTime = formatter.format(date);

    return formattedTime;
  }
}
