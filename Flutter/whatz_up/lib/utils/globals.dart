export 'dart:io';
export 'package:flutter/foundation.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

export 'package:go_router/go_router.dart';
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:flutter_locales/flutter_locales.dart';
export 'package:flutter_local_notifications/flutter_local_notifications.dart';
export 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:chat_bubbles/chat_bubbles.dart';
export 'package:audioplayers/audioplayers.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:story_view/story_view.dart';
export 'package:whatsapp_story_editor/whatsapp_story_editor.dart';
export 'package:image_picker/image_picker.dart';

export 'package:whatz_up/utils/routes.dart';
export 'package:whatz_up/utils/themes.dart';

export 'package:whatz_up/models/story.dart';
export 'package:whatz_up/utils/boxes.dart';
export 'package:whatz_up/utils/notifications.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Cubit<String> {
  SearchBloc() : super('');

  void updateSearch(String search) {
    emit(search);
  }
}
