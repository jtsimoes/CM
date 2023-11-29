import "package:go_router/go_router.dart";
import "package:whatz_up/pages/chat.dart";
import "package:whatz_up/pages/home.dart";
import "package:whatz_up/pages/stories.dart";

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
      builder: (context, state) => ChatPage(id: state.pathParameters['userId']),
    ),
    GoRoute(
      name: "story",
      path: "/story",
      builder: (context, state) => const StoriesPage(),
    ),
  ],
);
