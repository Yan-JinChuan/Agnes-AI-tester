# Agnes AI 测试台 (Agnes AI Tester)

Agnes AI 测试台是一个用于在本地验证与调试 Agnes AI OpenAI 兼容 API 的 Flutter 跨平台客户端应用（支持桌面端、移动端与 Web）。它集成了文本聊天、图片生成和视频生成能力，便于开发者在本地可视化配置请求参数、追踪异步任务、调试网络响应并持久化测试历史。

---

## 功能概览

- **文本聊天**：支持多轮对话上下文、会话切换与 SQLite 本地持久化。
- **图片生成**：支持提示词调优、输出分辨率配置、结果即时预览与统一本地媒体缓存。
- **视频生成**：完整支持 Agnes Video V2.0 规格（长宽比、帧数、帧率、图生视频/首尾关键帧、推理步数、种子和负向提示词）；自动轮询后台生成进度，任务完成后保存记录并支持原地播放。
- **连接与模型配置**：API Key、Base URL 及各类型模型配置保存在本地 SQLite；支持一键获取最新模型目录并快速选取，亦支持手动覆盖。
- **媒体统一缓存**：桌面端和移动端可通过系统原生目录选择器自定义媒体缓存路径（图片存入 `images/`，视频存入 `videos/`）；Web 端自动适配浏览器沙箱限制。
- **脱敏网络日志**：通过 Dio 拦截器在控制台输出结构化的请求、响应及错误日志，并自动对 API Key 等敏感凭据实施掩码脱敏。

---

## 技术栈与现代语言特性

- **Flutter / Dart**（全面采用 Dart 3.13+ 语言特性，包括原生主构造函数 Primary Constructors）
- **状态管理**：`flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`（类型安全的响应式状态管理）
- **不可变模型**：`freezed` + `json_serializable`（**全面使用 Dart 3.13+ 主构造函数新语法**）
- **网络通信**：`dio` + `retrofit` + `retrofit_generator`（声明式 REST 客户端与统一异常归一化）
- **本地数据库**：`sqflite`（跨平台 SQLite 持久化）
- **声明式路由**：`go_router`（路由注册与底部/侧边导航）
- **媒体播放**：`video_player` + `cached_video_player_plus`
- **代码生成器**：`build_runner`

---

## 软件架构

本项目采用 **Feature-First（按功能垂直切分）结合 MVVM + Repository** 的架构。UI 逻辑、业务流程与底层数据访问严格物理隔离：

```text
lib/src/
├── app.dart                         MaterialApp.router 全局配置与主题定义
├── app_shell.dart                   应用主框架：导航切换与连接设置入口
├── routing/                         go_router 路由表与路由拦截配置
├── core/                            跨功能公共基础设施（纯技术支持，不承载业务）
│   ├── cache/                       统一媒体文件缓存服务 (AppMediaCache)
│   ├── config/                      运行时配置与环境变量
│   ├── network/                     DioApiClient、拦截器与统一网络异常（仅通用能力）
│   └── storage/                     SQLite 数据库工厂与迁移管理 (AppDatabase)
└── features/                        业务功能模块
    ├── chat/                        文本聊天功能 (Data / Domain / Presentation)
    ├── generation/                  图片与视频生成功能 (Data / Domain / Presentation)
    └── settings/                    连接设置与模型目录管理 (Data / Domain / Presentation)
```

### 单向数据流动模型

```text
[ View (UI Widget) ]
       │ 1. 监听 State (ref.watch) / 触发业务动作 (ref.read)
       ▼
[ ViewModel (Riverpod Notifier) ]
       │ 2. 参数判空与业务校验，面向抽象接口调用数据
       ▼
[ Repository (Data Coordination) ]
       ├── 3. 访问网络 ──> [ RemoteDataSource (Retrofit/Dio) ]
       └── 3. 访问本地 ──> [ LocalDataSource (SQLite Database) ]
       │
       ▼ 4. 将网络 DTO 转换为纯业务 Domain Entity
[ ViewModel ]
       │ 5. 更新不可变的 Freezed State
       ▼
[ View ] (响应式重绘界面；由 View 自行持有 Context 执行弹窗或路由跳转)
```

注意：完整的架构禁令、各层调用规则及 AI 编码约束，请查阅根目录下的 `AGENTS.md`。

### 网络层与模型约定

1. **通用客户端与业务接口分离**：`lib/src/core/network/` 只负责 Dio 实例、Base URL、鉴权、超时、日志和异常归一化；不允许引用具体 feature。聊天、图片、视频、模型目录的 Retrofit API 与 DTO 分别放在对应的 `lib/src/features/<feature>/data/datasources/`；各 feature 在自己的 `data/di/` 中装配 Repository。

2. **现代 Freezed 语法**：所有不可变 State 与网络 DTO 均采用 Dart 3.13+ 主构造函数编写，彻底废弃旧版工厂构造方法：

   ```dart
   @freezed
   class VideoTaskDto({
     required String id,
     required String status,
     String? videoUrl,
   }) with _$VideoTaskDto {
     factory VideoTaskDto.fromJson(Map<String, dynamic> json) =>
         _$VideoTaskDtoFromJson(json);
   }
   ```

3. **接口防腐与分层映射**：feature 的 RemoteDataSource 调用本 feature 的 Retrofit API，负责 DTO 到 Domain 的兼容映射；LocalDataSource 负责本 feature 的 SQLite SQL；RemoteDataSource Provider 与数据源放在同一文件，Repository 实现负责协调远程与本地数据源；表现层绝不接触 Dio Response、SQLite `Database` 或原始 Map。ViewModel 只导入 `domain/repositories` 抽象和本 feature `data/di/` 中的抽象 Provider。

4. **数据库边界**：`core/storage/AppDatabase` 只负责数据库初始化、建表、迁移和连接生命周期，不包含聊天、图片、视频业务查询或 CRUD。聊天、图片和视频的 SQL 分别位于对应 feature 的 `data/datasources/*_local_data_source.dart`；现有 `AppConfigDao` 的配置事务仍保留在 `core/storage`。

---

## 本地开发与运行

### 1. 运行项目

推荐使用 FVM 确保本地 Flutter SDK 版本一致：

```bash
# 安装依赖
fvm flutter pub get

# 本地运行
fvm flutter run
```

### 2. 代码生成与静态校验

当修改了带有 `@riverpod`、`@freezed`、`@RestApi` 或 `@JsonSerializable` 注解的文件后，必须运行 `build_runner` 生成代码：

```bash
# 执行代码生成并覆盖冲突
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 格式化代码
fvm dart format lib test

# 静态代码分析
fvm flutter analyze --no-pub --suppress-analytics

# 运行单元测试
fvm flutter test --no-pub --suppress-analytics
```

注意：`*.g.dart` 与 `*.freezed.dart` 均为生成文件，严禁手动修改。

---

## 初始连接配置说明

首次启动应用后，请点击右上角 **“连接设置”**，配置测试凭证：

- **Base URL**：`https://apihub.agnes-ai.com/v1`
- **文本模型**：`agnes-2.5-flash`
- **图片模型**：`agnes-image-2.1-flash`
- **视频模型**：`agnes-video-v2.0`
- **缓存目录**：留空使用应用默认内部缓存目录，或选择本机具备读写权限的绝对路径。

所有配置信息与历史生成记录均保存在本地 SQLite 数据库文件（`agnes_ai_tester.db`）中，应用重启后自动恢复。

---

## Agnes API 参考

- **视频任务创建**：`POST /v1/videos`
- **视频状态轮询**：`GET /agnesapi?video_id=...`
- 轮询至任务完成后，解析响应中的 `metadata.url` 作为播放源，任务参数（`size`、`seconds`、`metadata.size_mapping` 等）将自动同步至历史任务记录中。

---

## 安全声明

本项目中的 API Key 直接保存在本地 SQLite 数据库中，仅用于本地开发与接口调试。生产环境切勿直接在客户端存储主账号 API Key，应由业务后端做代理转发与鉴权。
