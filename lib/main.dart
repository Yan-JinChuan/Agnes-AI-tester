import 'package:agnes_ai_tester/src/core/config/app_config.dart';
import 'package:agnes_ai_tester/src/core/config/app_config_provider.dart';
import 'package:agnes_ai_tester/src/core/storage/app_config_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fvp/fvp.dart' as fvp;

import 'src/app.dart';
import 'src/core/storage/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final dao = AppConfigDao(await db.database);
  final initialConfig = await dao.readConfig() ?? const AppConfig();

  fvp.registerWith(
    options: {
      // 持久化视频缓存由 CachedVideoPlayerPlus 统一管理，避免与 FVP
      // 的独立磁盘缓存重复保存同一视频。
      'player': {
        // 起播缓冲与探针参数必须作为 FVP 的播放器属性传入。
        'buffer': '1048576',
        'avformat.probesize': '131072',
        'avformat.analyzeduration': '100000',

        // 网络连接与重连参数同样属于播放器属性。
        'avformat.timeout': '10000000',
        'avformat.reconnect': '1',
        'avformat.reconnect_streamed': '1',
        'avformat.reconnect_delay_max': '5',
      },

      /* ================= 2. 解码与渲染加速 ========================== */
      // 解码器优先队列：优先走系统原生硬解，硬解失败自动无缝回退到 FFmpeg 软解
      // Android 走 mediacodec，iOS 走 videotoolbox，Windows 走 D3D11/DXVA2
      'video.decoders': [
        'MFT:d3d=11',
        'D3D11',
        'DXVA',
        'VT',
        'MediaCodec',
        'FFmpeg',
      ],

      /* ================= 3. 日志级别 =============================== */
      // global 才是 FVP 传递 MDK 全局属性的入口。
      'global': {'log': kDebugMode ? 'info' : 'warning'},
    },
  );

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        appConfigProvider.overrideWith(
          () => AppConfigNotifier(initialConfig: initialConfig),
        ),
      ],
      child: const AgnesApp(),
    ),
  );
}
