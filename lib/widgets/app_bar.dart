import 'package:flutter/material.dart';
import 'package:kingfisher/widgets/elements/back_button.dart';

AppBar appBar({
  String title = '',
  @required bool backButton,
  @required BuildContext context,
}) =>
    AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      automaticallyImplyLeading: backButton,
      leading: backButton ? backButtonWidget(context: context) : null,
    );

AppBar bar = AppBar();
