import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

import 'package:agnes_ai_tester/src/core/lifecycle/app_lifecycle_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('tracks lifecycle transitions that should suspend app resources', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appLifecycleProvider.notifier);
    notifier.didChangeAppLifecycleState(AppLifecycleState.paused);

    final paused = container.read(appLifecycleProvider);
    expect(paused.shouldSuspendResources, isTrue);
    expect(paused.isResumed, isFalse);

    notifier.didChangeAppLifecycleState(AppLifecycleState.resumed);

    final resumed = container.read(appLifecycleProvider);
    expect(resumed.isResumed, isTrue);
    expect(resumed.shouldSuspendResources, isFalse);
  });

  test('increments the memory pressure revision for each event', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appLifecycleProvider.notifier);
    final before = container.read(appLifecycleProvider).memoryPressureRevision;

    notifier.didHaveMemoryPressure();
    notifier.didHaveMemoryPressure();

    expect(
      container.read(appLifecycleProvider).memoryPressureRevision,
      before + 2,
    );
  });
}
