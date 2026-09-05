import 'dart:developer';

import 'package:talker/talker.dart';

final talker = Talker(
  logger: TalkerLogger(
    output: (message) => log(message),
  ),
);
