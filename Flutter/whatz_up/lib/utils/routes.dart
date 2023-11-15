import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:whatz_up/pages/chat.dart";
import "package:whatz_up/pages/error.dart";
import "package:whatz_up/pages/home.dart";
import "package:whatz_up/pages/stories.dart";

final router = GoRouter(
  initialLocation: "/",
  errorPageBuilder: fade(const ErrorPage()),
  routes: [
    GoRoute(
      name: "home",
      path: "/",
      builder: (context, state) => const HomePage(),
      //pageBuilder: fade(const HomePage()),
    ),
    GoRoute(
      name: "chat",
      path: "/chat/:userId",
      builder: (context, state) => ChatPage(id: state.pathParameters['userId']),
      //pageBuilder: fade(const ChatPage()),
    ),
    GoRoute(
      name: "story",
      path: "/story",
      builder: (context, state) => const StoriesPage(),
      //pageBuilder: fade(const ChatPage()),
    ),
  ],
);

// Example fade transition
CustomTransitionPage fadeTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

// Boilerplate to not repeat entire constructor in the page builder of each route.
// If you want you can use a different transition for each route, just call a similar function with a new transition!
Page<dynamic> Function(BuildContext, GoRouterState) fade(
  Widget child,
) =>
    (BuildContext context, GoRouterState state) {
      return fadeTransition(
        context: context,
        state: state,
        child: child,
      );
    };
