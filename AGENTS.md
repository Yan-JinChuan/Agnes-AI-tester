# Agnes AI Tester 项目协作规范与 AI 编程指南

> **CRITICAL NOTICE FOR AI CODING AGENTS**  
> 本文件包含本项目的最高架构约束。AI 编程助手在生成、重构 Dart/Flutter 代码时必须严格遵守本文件中的所有规则。任何违反分层约束、在 ViewModel 中使用 `BuildContext`、在 `shared` 中耦合业务代码或使用 Freezed 旧版语法的代码均属不合格交付。

---

## 1. 架构硬性红线（Strict Red Lines）

| 严禁行为（STRICTLY FORBIDDEN ❌）                          | 正确规范（MUST FOLLOW ✅）                                                                  |
|:----------------------------------------------------|:-------------------------------------------------------------------------------------|
| **在 ViewModel 中传入、持有或使用 `BuildContext`**            | ViewModel 必须与 UI 引擎解耦。页面跳转、弹窗、SnackBar、软键盘收起**必须由 View 自行持有 Context 执行**。            |
| **在 ViewModel 中导入 `package:flutter/material.dart`** | ViewModel 必须是纯 Dart 逻辑，保持单测独立性。如需注解可导入 `meta` 或 `foundation`。                        |
| **`shared/` 中导入或耦合任何 `features/` 代码**               | `shared/` 属于纯通用视觉资产，**严禁感知任何 Feature 业务概念**；全工程严格遵守 `features ➔ shared ➔ core` 单向依赖。 |
| **在 `core/` 中编写具体的视觉 UI 控件**                        | `core/` 必须保持为纯技术基建底座（网络、数据库、代理、缓存引擎）；公共 UI 组件统一收敛至 `shared/widgets/`。                |
| **View 跨层直接调用 Dio、SQLite 或 Repository**             | View 只能通过 `ref.watch` / `ref.read` 与当前特性的 **ViewModel** 交互。                          |
| **ViewModel 跨层直接调用 Dio、ApiClient 或 SQLite**         | ViewModel 只能面向 **Repository 抽象接口**编程，绝不能直连底层数据源。                                     |
| **使用 Freezed 旧版工厂构造函数写法**                           | **必须使用 Dart 3.13+ 原生主构造函数（Primary Constructor）** 定义不可变状态与模型。                         |
| **在 View 中使用 `Timer` 轮询视频/接口状态**                    | 轮询、重试与数据状态合并属于 **ViewModel / Repository** 的职责，View 只负责渲染状态。                          |
| **手动修改 `*.g.dart` 或 `*.freezed.dart` 文件**           | 严禁手工修改生成文件。必须修改注解源文件并通过 `build_runner` 重新构建。                                         |
| **在 State 中散落多个孤立的布尔变量**                            | 页面状态必须收敛为一个不可变的 Freezed State（如统一管理 `isLoading`、数据列表、`error`）。                       |
| **生成完全无注释充斥无意义废话的“裸奔代码”**                           | 公共类、核心方法必须包含 `///` 文档注释；复杂逻辑必须使用中文分步注释阐明**“为什么这么写（Why）”**而非解释语法。                     |

---

## 2. 目录分层与职责边界

工程骨架由 **`core`（技术底座）**、**`shared`（通用公共资产）** 与 **`features`（业务特性）** 构成：

```text
lib/src/
├── core/                            # 基础设施：纯技术底层驱动（零视觉 UI，零业务）
│   ├── cache/                       # 媒体磁盘缓存管理、视频边下边播本地代理服务 (Proxy)
│   ├── config/                      # 运行时全局配置 (AppConfig) 与常驻内存状态
│   ├── network/                     # DioApiClient、全局拦截器、统一异常
│   └── storage/                     # SQLite 底座工厂 (AppDatabase)、AppConfigDao
│
├── shared/                          # 跨功能共享层：零业务概念的通用视觉积木
│   ├── theme/                       # 设计系统规范 (AppColors, AppTextStyles)
│   └── widgets/                     # 通用 UI 组件 (按组件属性分类)
│       ├── image/                   # 通用图片加载组件 (AppCachedImage)
│       ├── video/                   # 通用视频播放器组件 (AppVideoPlayer)
│       └── buttons/                 # 通用基础按钮 (AppLoadingButton)
│
└── features/<feature>/              # 业务特性模块 (Feature-First)
    ├── data/
    │   ├── datasources/             # Retrofit API、RemoteDataSource、LocalDataSource (SQLite)
    │   ├── models/                  # DTO 网络模型 (Freezed + fromJson)
    │   ├── repositories/            # Repository 抽象接口的具体实现类 (*_impl.dart)
    │   └── di/                      # 模块装配组合根 (暴露 RepositoryProvider)
    ├── domain/                      # 纯 Dart 业务核心 (零 Flutter、Dio、SQLite 依赖)
    │   ├── models/                  # 业务领域实体 (Domain Entity) 与业务枚举
    │   └── repositories/            # 仓库抽象契约接口 (abstract interface class)
    └── presentation/                # 表现层 (MVVM)
        ├── viewmodels/              # Riverpod Notifier (ViewModel) 与不可变 State
        ├── views/                   # 页面级组件 (*View)：布局、Context 交互、路由跳转
        ├── widgets/                 # 模块内私有展示组件 (纯入参渲染，无数据源读取)
        └── extensions/              # 表现层扩展：将 Domain 状态转换为 UI 文案、颜色
```

### 2.1 依赖关系法则（单向漏斗）

```text
[ features/ (业务模块) ] ──> 依赖 ──> [ shared/ (公共 UI 资产) ] ──> 依赖 ──> [ core/ (底层技术底座) ]
```

1. **core/ 是最底层**：绝对不可 import shared/ 或 features/。
2. **shared/ 是通用积木**：只依赖 core/ 和 Flutter SDK；**严禁导入任何 features/**（即 shared/ 不得出现任何具体的业务模型、DTO 或 ViewModel）。
3. **features/ 是消费方**：可自由组合使用 shared/ 的组件和 core/ 的能力。

### 2.2 模块内部 DTO 与 Domain 隔离

- RemoteDataSource 只负责调用 Retrofit API 并**返回/接收 DTO**，严禁出现 Domain 类型。
- RepositoryImpl 是 DTO 与 Domain 的**唯一转换边界**。调用 DTO 的 toDomain() / fromDomain() 完成清洗后向上传递。
- 业务 SQL 必须由具体 feature 的 `*_local_data_source.dart` 编写，Repository 不得直接拼接 SQL。

---

## 3. Freezed 规范（Dart 3.13+ 原生主构造函数）

**严禁使用旧版 const factory Foo(...) = \_Foo;**，必须使用主构造函数语法：

```dart
// 1. UI State
@freezed
class ExampleState({
  List<String> items = const [],
  bool isLoading = false,
  String? error,
}) with _$ExampleState;

// 2. 网络传输 DTO (含 JSON 序列化)
@freezed
class ExampleDto({
  required String id,
  required String name,
  String? description,
}) with _$ExampleDto {
  factory ExampleDto.fromJson(Map<String, dynamic> json) =>
      _$ExampleDtoFromJson(json);
}
```

## 4. 代码注释与 Review 友好性规范（Review-Driven Documentation）

AI 生成的所有代码必须服务于**Code Review**：

1. **类与方法级文档（`///`）**：
    - 所有的 ViewModel 方法、Repository 契约、Shared 组件必须有中文 `///` 文档。
    - 明确标注：**设计意图**、**入参边界**、**驱动的状态变化**（如：“触发后将 `isLoading` 置为 true”）。
2. **行内注释原则（解释 Why，禁止解释 What）**：
    - ❌ 严禁废话：不要写 `// 初始化变量`、`// if 判断是否为空` 等肉眼可见的语法翻译。
    - ✅ 解释意图：遇到非显而易见的逻辑、异常捕获、降级逻辑、缓存时间设置，必须说明**业务原因**（如：`// 后端偶发 404 时安全返回空列表，避免阻断页面`）。
3. **复杂异步链路步骤化**：
    - 超过 15 行或跨越多个 `await` 的业务方法，必须使用 `// 1. 校验...`、`// 2. 调接口...`、`// 3. 落库...` 进行阶段打点。

## 5. Few-Shot 标准代码范式

### 5.1 业务 View 消费 shared 通用组件范式

```dart
// features/generation/presentation/views/video_preview_card.dart
import 'package:flutter/material.dart';
import 'package:agnes_ai_tester/src/features/generation/domain/models/video_task.dart';
import 'package:agnes_ai_tester/src/shared/widgets/video/app_video_player.dart';

class VideoPreviewCard extends StatelessWidget {
  final VideoTask task; // 业务 Domain 实体

  const VideoPreviewCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(task.prompt),
          // ⭐ 直接像使用原生 Widget 一样消费 shared 通用组件
          if (task.canPlay)
            AppVideoPlayer(
              videoUrl: task.playUrl!,
              autoPlay: false,
            ),
        ],
      ),
    );
  }
}
```

### 5.2 View 交互、监听与 Context 消费范式

```dart
// presentation/views/example_view.dart
// 仅展示核心交互：收起键盘、await 结果、mounted 校验、Context 跳转/弹窗
Future<void> _handleSubmit(BuildContext context, WidgetRef ref, TextEditingController controller) async {
  FocusScope.of(context).unfocus();

  final success = await ref
      .read(exampleViewModelProvider.notifier)
      .addItem(controller.text);

  if (!context.mounted) return;

  if (success) {
    controller.clear();
    context.push('/detail');
  }
}

@override
Widget build(BuildContext context) {
    final state = ref.watch(exampleViewModelProvider);

    // 在 Widget.build 中监听一次性错误提示
    ref.listen(exampleViewModelProvider.select((s) => s.error), (prev, next) {
        if (next != null && next != prev) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next)),
          );
        }
    });
    
    return Scaffold(
      appBar: AppBar(title: const Text('示例')),
      body: Column(
        children: [
          ...
          FilledButton(
            onPressed: state.isLoading ? null : _handleSubmit,
            child: const Text('提交'),
          ),
        ],
      ),
    );
}
```

### 5.3 Repository 协调与 DTO 转换范式

```dart
// data/repositories/example_repository_impl.dart
class ExampleRepositoryImpl implements ExampleRepository {
  ExampleRepositoryImpl({
    required ExampleRemoteDataSource remote,
    required ExampleLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  final ExampleRemoteDataSource _remote;
  final ExampleLocalDataSource _local;

  @override
  Future<ExampleItem> createItem(String title) async {
    final dto = await _remote.create(title);
    await _local.save(dto);
    return dto.toDomain(); // ⭐ 在 Repository 统一将 DTO 清洗为 Domain 实体
  }
}
```

---

## 6. 开发与构建指令

代码变更涉及注解时，必须按序执行：

```bash
# 1. 重新生成代码
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 2. 格式化与静态代码检查 (必须 0 warning 0 error)
fvm dart format lib test
fvm flutter analyze --no-pub --suppress-analytics

# 3. 运行单元测试
fvm flutter test --no-pub --suppress-analytics
```

---

## 7. AI 交付前自检清单（Pre-flight Checklist）

AI 在输出代码之前，必须确认：

- [ ] **Review 友好性达标**：核心方法均配备 `///` 意图文档，长逻辑有中文分步打点，未出现无意义废话注释，注释是否使用的是中文。
- [ ] shared 零业务耦合：shared/ 目录下的组件未 import 任何 features/ 中的模型、DTO 或 ViewModel。
- [ ] 零 Context 泄漏：ViewModel 中不存在任何 BuildContext 类型的参数或字段。
- [ ] 无 UI 库污染：ViewModel 所在文件没有引入 package:flutter/material.dart。
- [ ] 主构造函数语法：所有 Freezed 类均采用 `class Xxx({ ... }) with _$Xxx;`，没有使用 `abstract class + factory`。
- [ ] 分层不越界：View 仅与 ViewModel 通信；ViewModel 仅依赖 Repository 接口；数据转换在 Data 层就地消化。
- [ ] 生成声明完整：涉及代码生成的源文件均包含格式正确的 `part '*.g.dart';` 与 `part '*.freezed.dart';`。
