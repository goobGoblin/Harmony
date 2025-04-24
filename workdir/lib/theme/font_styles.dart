// lib/theme/font_styles.dart

import 'package:flutter/material.dart';

class AppFontStyles {
  // Title style: size 16, semibold
  static const TextStyle title = TextStyle(
    fontFamily: 'NeueRegrade',
    fontSize: 16.0,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // EntryTitle style: size 14, semibold
  static const TextStyle entryTitle = TextStyle(
    fontFamily: 'NeueRegrade',
    fontSize: 14.0,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // EntrySubtitle style: size 14, medium
  static const TextStyle entrySubtitle = TextStyle(
    fontFamily: 'NeueRegrade',
    fontSize: 14.0,
    fontWeight: FontWeight.w500, // Medium
  );

  // Description style: size 11, regular
  static const TextStyle description = TextStyle(
    fontFamily: 'NeueRegrade',
    fontSize: 11.0,
    fontWeight: FontWeight.w400, // Regular
  );
}
