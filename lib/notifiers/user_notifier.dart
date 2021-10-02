import 'package:flutter/material.dart';
import 'package:kingfisher/models/kingfisher_user.dart';

class UserNotifier {
  final user = ValueNotifier<KingfisherUser>(KingfisherUser());
}
