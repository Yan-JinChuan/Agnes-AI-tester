# Agnes AI Tester 项目协作规范与 AI 编程指南

> **CRITICAL NOTICE FOR AI CODING AGENTS**  
> 本文件包含本项目的最高架构约束。AI 编程助手在生成、重构 Dart/Flutter 代码时必须严格遵守本文件中的所有规则。任何违反分层约束、在 ViewModel 中使用 `BuildContext` 或使用 Freezed 旧版语法的代码均属不合格交付。

---

## 1. 架构硬性红线（Strict Red Lines）

| 严禁行为（STRICTLY FORBIDDEN ❌）                          | 正确规范（MUST FOLLOW ✅）                                                       |
|:----------------------------------------------------|:--------------------------------------------------------------------------|
| **在 ViewModel 中传入、持有或使用 `BuildContext`**            | ViewModel 必须与 UI 引擎解耦。页面跳转、弹窗、SnackBar、软键盘收起**必须由 View 自行持有 Context 执行**。 |
| **在 ViewModel 中导入 `package:flutter/material.dart`** | ViewModel 必须是纯 Dart 逻辑，保持单测独立性。如需注解可导入 `meta` 或 `foundation`。             |
| **View 跨层直接调用 Dio、SQLite 或 Repository**             | View 只能通过 `ref.watch` / `ref.read` 与当前特性的 **ViewModel** 交互。               |
| **ViewModel 跨层直接调用 Dio、ApiClient 或 SQLite**         | ViewModel 只能面向 **Repository 抽象接口**编程，绝不能直连底层数据源。                          |
| **使用 Freezed 旧版工厂构造函数写法**                           | **必须使用 Dart 3.13+ 原生主构造函数（Primary Constructor）** 定义不可变状态与模型。              |
| **在 View 中使用 `Timer` 轮询视频/接口状态**                    | 轮询、重试与数据状态合并属于 **ViewModel / Repository** 的职责，View 只负责渲染状态。               |
| **手动修改 `*.g.dart` 或 `*.freezed.dart` 文件**           | 严禁手工修改生成文件。必须修改注解源文件并通过 `build_runner` 重新构建。                              |
| **在 State 中散落多个孤立的布尔变量**                            | 页面状态必须收敛为一个不可变的 Freezed State（如统一管理 `isLoading`、数据列表、`error`）。            |

---

## 2. 目录分层与职责边界

项目采用 **Feature-First（按业务功能切分）结合 MVVM + Repository** 的架构。所有业务代码均位于 `lib/src/features/<feature>/` 目录下：

```text
features/<feature>/
├── data/                    # 数据层：网络与本地数据读写、转换与 Repository 实现
│   ├── datasources/         # RemoteDataSource (Retrofit/Dio), LocalDataSource (SQLite)
│   ├── models/              # DTO 网络模型 (Freezed + fromJson)
│   └── repositories/        # Repository 抽象接口的具体实现类
├── domain/                  # 领域层：纯业务实体与仓库契约（纯 Dart，无 Flutter 依赖）
│   ├── models/              # 业务领域实体（Domain Entity）
│   └── repositories/        # 仓库抽象接口 (abstract interface class)
└── presentation/            # 表现层 (MVVM)
    ├── viewmodels/          # Riverpod Notifier (ViewModel) 与不可变 State
    ├── views/               # 页面级组件 (*View)：排版、Context 行为、路由跳转
    └── widgets/             # 模块内私有可复用组件 (纯入参渲染，无数据源读取)
```

### 职责约束

- **presentation/views（View）**：负责 UI 布局、动画、滚动以及 `TextEditingController` 等生命周期管理。负责根据 ViewModel 的返回结果使用 `context` 触发跳转或弹窗。
- **presentation/viewmodels（ViewModel）**：基于 `riverpod_annotation` 生成。负责管理页面状态、用户输入判空与业务校验、调用 Repository 获取数据。对外暴露不可变状态与语义化动作方法。
- **domain（Domain）**：定义业务实体（Entity）以及仓库抽象接口（`abstract interface class XxxRepository`）。
- **data（Data）**：负责 Dio/Retrofit 接口调用、SQLite 读写、JSON 序列化与反序列化，并在 Repository 实现中将 DTO 转换为 Domain Entity。具体 feature 的 Retrofit API、网络 DTO 和 RemoteDataSource 必须放在 `features/<feature>/data/datasources/`，不得集中到 `core/network`。
- **data/datasources 中的 LocalDataSource**：负责本 feature 的 SQL、查询条件、事务和 SQLite 行数据读写；Repository 不得直接调用 `Database` 或在自身编写 SQL。
- **data/repositories**：只放 Repository 实现类（例如 `ChatRepositoryImpl`、`ImageRepositoryImpl`），不得把抽象接口放回 data 层。
- **domain/models 与 domain/repositories**：只放纯 Dart 领域模型和 Repository 抽象接口；不得导入 Dio、SQLite、Retrofit 或 Flutter。
- **core（Core）**：只存放跨功能通用基础设施（ApiClient、Dio 配置、拦截器、统一异常、数据库工厂、统一媒体缓存 AppMediaCache）。`AppDatabase` 只能负责数据库路径、连接生命周期、建库、建表和迁移，不得暴露聊天、生成等业务 CRUD 方法，也不得承载 feature SQL。现有 `AppConfigDao` 是明确保留的配置持久化例外，除非用户明确要求，不要迁移或拆分它。
- **feature data/di（模块组合根）**：每个 feature 在自己的 `data/di/` 中装配本 feature 的 Repository Provider。Provider 对外只暴露 Domain Repository 抽象；ViewModel 不得直接导入 `data/repositories/*_impl.dart`。跨 feature 的通用客户端仍只能放在 `core/network`。

### 网络层硬性边界

```text
core/network/                         features/<feature>/data/datasources/
通用 Dio 客户端、配置、日志、异常       Retrofit API、Freezed DTO、RemoteDataSource
                 \                   /
                  \                 /
                   Feature Repository
```

- `ApiClient` 只能暴露与具体业务无关的请求执行能力，例如 `execute<T>(...)`；不能依赖 `ChatApi`、`VideoApi` 或任何 feature DTO。
- `AppDatabase` 只能暴露通用的 `database` 连接入口；聊天、图片和视频业务 SQL 必须由对应 feature 的 `*_local_data_source.dart` 执行。`AppConfigDao` 按现有约定保留在 `core/storage`。
- 每个 feature 的 `*_api.dart` 负责 Retrofit endpoint 声明，`*_api_models.dart` 负责请求/响应 DTO，`*_remote_data_source.dart` 负责调用 API 和 DTO/Domain 边界映射。
- RemoteDataSource Provider 必须与 RemoteDataSource 接口放在同一个 `*_remote_data_source.dart` 文件中；Repository 实现通过该 Provider 获取远程数据。Repository Provider 放在本 feature 的 `data/di/` 中，并使用同一个 `DioApiClient.dio` 创建各 feature 的 Retrofit API；ViewModel 和 View 不得直接构造或调用 Retrofit API。

---

## 3. Freezed 规范：统一使用 Dart 3.13+ 主构造函数

本项目全面采用 Dart 3.13+ 原生主构造函数语法编写 Freezed 类。严禁使用旧版 `const factory Foo(...) = _Foo;` 语法。

### 3.1 UI State 定义规范

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_state.freezed.dart';

@freezed
class ExampleState({
  List<String> items = const [],
  bool isLoading = false,
  String? error,
}) with _$ExampleState;
```

### 3.2 带 JSON 序列化的 DTO 定义规范

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_dto.freezed.dart';
part 'example_dto.g.dart';

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

---

## 4. Few-Shot 标准代码范式

### 4.1 Riverpod ViewModel 范式

```dart
// lib/src/features/example/presentation/viewmodels/example_view_model.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:agnes_ai_tester/src/features/example/data/di/example_data_providers.dart';
import 'package:agnes_ai_tester/src/features/example/presentation/viewmodels/example_state.dart';

part 'example_view_model.g.dart';

@riverpod
class ExampleViewModel extends _$ExampleViewModel {
  @override
  ExampleState build() {
    return const ExampleState();
  }

  // 执行业务逻辑与校验，返回操作结果给 View，绝不接收 BuildContext
  Future<bool> addItem(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      state = state.copyWith(error: '内容不能为空');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(exampleRepositoryProvider);
      final newItem = await repository.createItem(trimmed);

      state = state.copyWith(
        items: [...state.items, newItem],
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }
}
```

### 4.2 View 交互、监听与 Context 跳转范式

```dart
// lib/src/features/example/presentation/views/example_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:agnes_ai_tester/src/features/example/presentation/viewmodels/example_view_model.dart';

class ExampleView extends ConsumerStatefulWidget {
  const ExampleView({super.key});

  @override
  ConsumerState<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends ConsumerState<ExampleView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    // 纯 UI 行为：收起键盘
    FocusScope.of(context).unfocus();

    // 调用 ViewModel 执行业务并获取结果
    final success = await ref
        .read(exampleViewModelProvider.notifier)
        .addItem(_controller.text);

    // 异步返回后，必须检查组件是否仍挂载在树上
    if (!mounted) return;

    // View 自行持有 context 执行页面跳转或弹窗
    if (success) {
      _controller.clear();
      context.push('/detail');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exampleViewModelProvider);

    // 监听全局/被动错误并弹 SnackBar
    ref.listen(exampleViewModelProvider.select((s) => s.error), (previous, next) {
      if (next != null && next != previous) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('示例')),
      body: Column(
        children: [
          if (state.isLoading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(state.items[index])),
            ),
          ),
          TextField(controller: _controller),
          FilledButton(
            onPressed: state.isLoading ? null : _handleSubmit,
            child: const Text('提交'),
          ),
        ],
      ),
    );
  }
}
```

### 4.3 Repository 契约与数据转换范式

```dart
// domain/repositories/example_repository.dart
abstract interface class ExampleRepository {
  Future<String> createItem(String title);
}

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
  Future<String> createItem(String title) async {
    final dto = await _remote.create(title);
    await _local.save(dto);
    return dto.name; // 转换为领域实体或业务数据
  }
}
```

---

## 5. 开发与构建指令

修改任何带有注解的代码后，必须在终端执行以下命令更新生成文件并验证：

### 5.1 重新生成代码

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### 5.2 格式化与静态代码检查

```bash
fvm dart format lib test
fvm flutter analyze --no-pub --suppress-analytics
```

### 5.3 运行单元测试

```bash
fvm flutter test --no-pub --suppress-analytics
```

---

## 6. AI 交付前自检清单（Pre-flight Checklist）

AI 在输出代码之前，必须确认：

- [ ] **零 Context 泄漏**：ViewModel 中不存在任何 `BuildContext` 类型的参数或字段。
- [ ] **无 UI 库污染**：ViewModel 所在文件没有引入 `package:flutter/material.dart`。
- [ ] **主构造函数语法**：所有 Freezed 类均采用 `class Xxx({ ... }) with _$Xxx;`，没有使用 `abstract class + factory`。
- [ ] **分层不越界**：View 仅与 ViewModel 通信；ViewModel 仅依赖 Repository 接口；数据转换在 Data 层就地消化。
- [ ] **生成声明完整**：涉及代码生成的源文件均包含格式正确的 `part '*.g.dart';` 与 `part '*.freezed.dart';`。
