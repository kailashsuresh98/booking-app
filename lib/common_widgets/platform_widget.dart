import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {
  Widget buildCuperentinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCuperentinoWidget(context);
    }
    return buildMaterialWidget(context);
  }
}
