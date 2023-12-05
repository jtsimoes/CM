import "package:go_router/go_router.dart";
import "package:whatz_up/pages/chat.dart";
import "package:whatz_up/pages/home.dart";
import "package:whatz_up/pages/stories.dart";
import "package:whatz_up/pages/profile.dart";
import "package:whatz_up/pages/settings.dart";

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
      name: "story",
      path: "/story/:userId",
      builder: (context, state) =>
          StoriesPage(userId: state.pathParameters['userId']),
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
