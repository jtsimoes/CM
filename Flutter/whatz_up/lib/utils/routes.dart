import "package:go_router/go_router.dart";
import "package:whatz_up/models/event.dart";
import "package:whatz_up/pages/chat.dart";
import "package:whatz_up/pages/home.dart";
import "package:whatz_up/pages/nearby.dart";
import "package:whatz_up/pages/stories.dart";
import "package:whatz_up/pages/event.dart";
import "package:whatz_up/pages/call.dart";
import "package:whatz_up/pages/profile.dart";
import "package:whatz_up/pages/settings.dart";

import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: "home",
      path: "/",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: "chat",
      path: "/chat/:userId",
      builder: (context, state) =>
          ChatPage(userId: state.pathParameters['userId']),
    ),
    GoRoute(
      name: "nearby",
      path: "/nearby",
      builder: (context, state) =>
          NearbyChatPage(device: state.extra as Device),
    ),
    GoRoute(
      name: "story",
      path: "/story/:userId",
      builder: (context, state) =>
          StoriesPage(userId: state.pathParameters['userId']),
    ),
    GoRoute(
      name: "event",
      path: "/event",
      builder: (context, state) => EventPage(event: state.extra as Event),
    ),
    GoRoute(
      name: "call",
      path: "/call/:userId",
      builder: (context, state) =>
          CallPage(userId: state.pathParameters['userId']),
    ),
    GoRoute(
      name: "profile",
      path: "/profile",
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      name: "settings",
      path: "/settings",
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
