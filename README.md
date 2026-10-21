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
- **声明式路由**：`go_router`（路由注册与导航切换）
- **媒体播放**：`video_player` + `cached_video_player_plus`
- **代码生成器**：`build_runner`

---

## 软件架构

本项目采用 **三层分级（Core / Shared / Features）结合 Feature-First MVVM + Repository** 的工程架构：

```text
lib/src/
├── app.dart                         MaterialApp.router 全局配置与应用入口
├── app_shell.dart                   应用主框架壳：导航联动与设置入口
├── routing/                         go_router 声明式路由表
│
├── core/                            【纯技术基建底座】（无视觉 UI，零具体业务）
│   ├── cache/                       AppMediaCache、视频边下边播本地代理服务 (Proxy)
│   ├── config/                      运行时全局配置 (AppConfig) 与常驻内存状态
│   ├── network/                     DioApiClient、全局拦截器与统一网络异常
│   └── storage/                     SQLite 数据库工厂与迁移 (AppDatabase)、DAO
│
├── shared/                          【跨功能公共资产】（零业务感知，高复用积木）
│   ├── theme/                       全局主题系统 (AppColors, AppTextStyles)
│   └── widgets/                     通用 UI 控件 (按组件属性分类)
│       ├── image/                   通用图片加载组件 (AppCachedImage)
│       ├── video/                   通用视频播放器组件 (AppVideoPlayer)
│       └── buttons/                 通用加载按钮 (AppLoadingButton)
│
└── features/                        【业务功能模块】（Feature-First）
    ├── chat/                        典型业务功能模块骨架：
    │   ├── data/
    │   │   ├── datasources/         Retrofit API、RemoteDataSource、LocalDataSource
    │   │   ├── models/              DTO 网络模型 (Freezed + fromJson)
    │   │   ├── repositories/        Repository 抽象接口的具体实现类
    │   │   └── di/                  模块装配组合根 (暴露 RepositoryProvider)
    │   ├── domain/
    │   │   ├── models/              业务领域实体 (Domain Entity) 与枚举
    │   │   └── repositories/        仓库抽象契约接口 (abstract interface class)
    │   └── presentation/
    │       ├── viewmodels/          Riverpod Notifier (ViewModel) 与不可变 State
    │       ├── views/               页面级组件 (*View)：布局、Context 交互、路由跳转
    │       ├── widgets/             功能内可复用展示组件 (纯展示)
    │       └── extensions/          表现层扩展 (Domain 状态到 UI 颜色/文案映射)
    ├── generation/                  图片与视频生成业务模块
    └── settings/                    连接设置与模型目录管理模块
```

### 单向数据流动模型

```text
[ View (UI Widget) ] ──消费──> [ Shared 组件 (如 AppVideoPlayer) ]
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

> **提示**：完整的架构禁令、各层调用规则及 AI 编码约束，请查阅根目录下的 **AGENTS.md**。

### 网络层与模型约定

1. **通用客户端与业务接口分离**：
   `core/network/` 只负责 Dio 实例、Base URL、鉴权拦截器、超时与异常归一化；各业务模块的 Retrofit API、DTO 和 RemoteDataSource 严格内聚于各自的 `features/<feature>/data/datasources/` 中。

2. **现代 Freezed 语法**：
   所有不可变 State 与网络 DTO 均采用 **Dart 3.13+ 主构造函数** 编写，彻底废弃旧版工厂构造方法：

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

3. **分层数据防腐**：

   - **RemoteDataSource**：只负责与 Retrofit API 交互，**输入输出严格限制为 DTO**，不感知 Domain 模型。
   - **RepositoryImpl**：充当防腐隔离墙，统一调用 DTO 的 `toDomain()` / `fromDomain()` 完成业务实体转换，并协调本地 SQLite 缓存。
   - **表现层隔离**：ViewModel 与 View 绝不接触 Dio Response、SQLite Database 或原始 Map。

4. **数据库职责收敛**：
   `AppDatabase` 仅负责数据库连接生命周期、多平台路径计算与版本迁移。具体的业务 CRUD SQL 严格隔离在各 feature 的 `*_local_data_source.dart` 中。

---

## 本地开发与运行

### 1. 运行项目

推荐使用 [**FVM**](https://fvm.app/) 确保本地 Flutter SDK 版本一致：

```bash
# 安装依赖
fvm flutter pub get

# 本地运行
fvm flutter run
```

### 2. 代码生成与静态校验

当修改了带有 `@riverpod`、`@freezed`、`@RestApi` 或 `@JsonSerializable` 注解的文件后，必须运行 build_runner 生成代码：

```bash
# 执行代码生成并覆盖冲突
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 格式化代码
fvm dart format lib test

# 静态代码分析 (必须 0 warning 0 error)
fvm flutter analyze --no-pub --suppress-analytics

# 运行单元测试
fvm flutter test --no-pub --suppress-analytics
```

> **注意**：`*.g.dart` 与 `*.freezed.dart` 均为生成文件，**严禁手动修改**。

---

## 初始连接配置说明

首次启动应用后，请点击右上角 **“连接设置”**，配置测试凭证：

- **Base URL**：[https://apihub.agnes-ai.com/v1](https://apihub.agnes-ai.com/v1)
- **文本模型**：agnes-2.5-flash
- **图片模型**：agnes-image-2.1-flash
- **视频模型**：agnes-video-v2.0
- **缓存目录**：留空使用应用默认内部缓存目录，或选择本机具备读写权限的绝对路径。

所有配置信息与历史生成记录均保存在本地 SQLite 数据库文件（agnes_ai_tester.db）中，应用重启后自动恢复。

---

## Agnes API 参考

本项目对接的 OpenAI 兼容接口及专属视频规范：

- **模型目录获取**：GET /v1/models
- **文本多轮对话**：POST /v1/chat/completions
- **图像生成测试**：POST /v1/images/generations
- **视频任务创建**：POST /v1/videos
- **视频状态轮询**：GET /agnesapi?video_id=...
   - 任务完成后自动解析 `metadata.url` 播放源，并提取 `size`、`seconds`、`metadata.size_mapping` 等元数据持久化至本地。

---

## 安全声明

本项目中的 API Key 直接保存在本地 SQLite 数据库中，**仅供本地开发与接口验证测试使用**。生产环境切勿直接在客户端存储高权限 API Key，应通过自己的业务后端建立安全代理与用户鉴权。