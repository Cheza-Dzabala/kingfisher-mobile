import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kingfisher/models/kingfisher_user.dart';

final userProvider = StateProvider<KingfisherUser>((_) {
  return KingfisherUser();
});
