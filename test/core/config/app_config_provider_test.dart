import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agnes_ai_tester/src/core/config/app_config.dart';
import 'package:agnes_ai_tester/src/core/config/app_config_provider.dart';

void main() {
  test('keeps notifier access when the initial config is overridden', () {
    const initialConfig = AppConfig(apiKey: 'initial-key');
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWith(
          () => AppConfigNotifier(initialConfig: initialConfig),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(appConfigProvider), initialConfig);

    final notifier = container.read(appConfigProvider.notifier);
    notifier.update(baseUrl: 'https://example.test/v1');

    expect(
      container.read(appConfigProvider),
      initialConfig.copyWith(baseUrl: 'https://example.test/v1'),
    );
  });

  test('hydrates the persisted config without writing it again', () {
    const persisted = AppConfig(
      apiKey: 'stored-key',
      baseUrl: 'https://stored.example/v1',
    );
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appConfigProvider.notifier);
    notifier.hydrate(persisted);

    expect(container.read(appConfigProvider), persisted);
  });
}
