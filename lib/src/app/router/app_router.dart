import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/views/chat_view.dart';
import '../../features/generation/presentation/views/image_generation_view.dart';
import '../../features/generation/presentation/views/video_generation_view.dart';
import '../app_shell.dart';
import 'not_found_screen.dart';

abstract final class AppRoute {
  static const chat = 'chat';
  static const image = 'image';
  static const video = 'video';
}

final appRouter = GoRouter(
  initialLocation: '/chat',
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              name: AppRoute.chat,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ChatView()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/image',
              name: AppRoute.image,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ImageGenerationView()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/video',
              name: AppRoute.video,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: VideoGenerationView()),
            ),
          ],
        ),
      ],
    ),
  ],
);
