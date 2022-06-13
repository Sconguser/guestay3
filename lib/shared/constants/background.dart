import 'package:flutter/material.dart';

const BoxDecoration backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.2, 0.3],
    colors: [
      gradientPrimaryColorTest,
      // gradientMiddleColorTest,
      gradientSecondaryColorTest,
      whiteBackgroundTest
    ],
  ),
);
const BoxDecoration loginBackGroundDecoration =
    BoxDecoration(color: gradientSecondaryColorTest);
const Color primaryColorTest = Color(0xFF33C9F9);
const Color gradientPrimaryColorTest = Color(0xFF33C9F9);
const Color gradientMiddleColorTest = Color(0xFF39C9F3);
const Color gradientSecondaryColorTest = Color(0xFFA6DAE7);
const Color whiteBackgroundTest = Color(0xFFFFFFFF);
