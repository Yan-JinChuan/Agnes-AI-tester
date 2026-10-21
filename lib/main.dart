import 'package:agnes_ai_tester/src/core/config/app_config.dart';
import 'package:agnes_ai_tester/src/core/config/app_config_provider.dart';
import 'package:agnes_ai_tester/src/core/storage/app_config_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fvp/fvp.dart' as fvp;

import 'src/app.dart';
import 'src/core/cache/app_media_cache.dart';
import 'src/core/storage/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final dao = AppConfigDao(await db.database);
  final initialConfig = await dao.readConfig() ?? const AppConfig();

  fvp.registerWith(
    options: {
      /* ================= 1. 磁盘与流式缓存控制 (重点) ================= */
      // 开启分片磁盘缓存（边下边播，第二次播放完全不耗流量）
      'cache_dir': AppMediaCache(configuredDirectory: initialConfig.cacheDirectory),
      'cache_max_entries': 200,                // 最多保留 200 个视频
      'cache_max_size': 500 * 1024 * 1024,     // 最大占用 500MB，超额自动 LRU 淘汰

      /* ================= 2. 毫秒级起播与预读控制 (秒开核心) ============= */
      // 起播缓冲阈值 (单位: 字节)：
      // 512KB ~ 1MB。只要网络拿到 1MB 数据，立刻点亮屏幕起播！
      'buffer': '1048576',

      // 探针优化：告诉 FFmpeg 不要花几百毫秒分析长视频，只看前 128KB 头部即刻开播
      'avformat.probesize': '131072',       // 128 KB
      'avformat.analyzeduration': '100000', // 100 毫秒

      /* ================= 3. 网络与超时容错 ========================== */
      // HTTP 连接超时与读取超时 (微秒，10秒 = 10,000,000)
      'avformat.timeout': '10000000',
      'avformat.reconnect': '1',             // 弱网或切网时自动尝试重连
      'avformat.reconnect_streamed': '1',
      'avformat.reconnect_delay_max': '5',   // 重连最大延迟（秒）

      /* ================= 4. 解码与渲染加速 ========================== */
      // 解码器优先队列：优先走系统原生硬解，硬解失败自动无缝回退到 FFmpeg 软解
      // Android 走 mediacodec，iOS 走 videotoolbox，Windows 走 D3D11/DXVA2
      'video.decoders': ['MFT:d3d=11', 'D3D11', 'DXVA', 'VT', 'MediaCodec', 'FFmpeg'],

      // 禁用不必要的音轨/字幕探测，节省解析时间
      'audio.decoders': ['FFmpeg'],

      /* ================= 5. 日志级别 =============================== */
      // 生产环境设为 'warning' 或 'quiet'，开发调试可设为 'debug'
      'log': kDebugMode ? 'info' : 'warning',
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
