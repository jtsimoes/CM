import "package:logger/logger.dart";

export 'dart:io';
export "package:flutter/foundation.dart";
export "package:flutter/material.dart";
export "package:flutter/services.dart";

export "package:go_router/go_router.dart";
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:flutter_locales/flutter_locales.dart';
export 'package:flutter_local_notifications/flutter_local_notifications.dart';
export 'package:shake_gesture/shake_gesture.dart';
export 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
export 'package:chat_bubbles/chat_bubbles.dart';
export "package:url_strategy/url_strategy.dart";
export 'package:audioplayers/audioplayers.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:story_view/story_view.dart';
export 'package:whatsapp_story_editor/whatsapp_story_editor.dart';
export 'package:image_picker/image_picker.dart';

export "package:whatz_up/utils/routes.dart";
export "package:whatz_up/utils/themes.dart";

export 'package:whatz_up/models/story.dart';
export 'package:whatz_up/utils/boxes.dart';
export 'package:whatz_up/utils/notifications.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 0,
    printTime: true,
  ),
);
