import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/settings/presentation/views/connection_settings_dialog.dart';
import 'features/settings/presentation/widgets/connection_status.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Row(
          children: [
            _AgnesLogo(),
            SizedBox(width: 12),
            Flexible(child: Text('Agnes AI 测试台')),
          ],
        ),
        actions: [
          const ConnectionStatus(),
          IconButton(
            tooltip: '连接设置',
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const ConnectionSettingsDialog(),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: '文本聊天',
          ),
          NavigationDestination(
            icon: Icon(Icons.image_outlined),
            selectedIcon: Icon(Icons.image),
            label: '图片生成',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie),
            label: '视频生成',
          ),
        ],
      ),
    );
  }
}

class _AgnesLogo extends StatelessWidget {
  const _AgnesLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6E6CFF), Color(0xFF9A66F7)],
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
    );
  }
}
