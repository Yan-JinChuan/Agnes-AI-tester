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

所有业务功能统一收敛在 `lib/src/features/<feature>/` 下（Feature-First）：

```text
features/<feature>/
├── data/
│   ├── datasources/         # Retrofit API、RemoteDataSource、LocalDataSource (SQLite)
│   ├── models/              # DTO 网络模型 (Freezed + fromJson)
│   ├── repositories/        # Repository 抽象接口的具体实现类 (*_impl.dart)
│   └── di/                  # 本模块 Repository Provider 装配（组合根）
├── domain/                  # 纯 Dart 业务核心（零 Flutter、Dio、SQLite 依赖）
│   ├── models/              # 业务领域实体（Domain Entity）与业务枚举
│   └── repositories/        # 仓库抽象契约接口 (abstract interface class)
└── presentation/            # 表现层 (MVVM)
    ├── viewmodels/          # Riverpod Notifier (ViewModel) 与不可变 State
    ├── views/               # 页面级组件 (*View)：布局、Context 交互、路由跳转
    ├── widgets/             # 功能内私有展示组件 (纯入参渲染，无数据源读取)
    └── extensions/          # 表现层扩展：将 Domain 状态转换为 UI 文案、颜色
```

### 2.1 核心分层红线与数据流向

**数据流动约束：**

View ➔ ViewModel ➔ Domain Repository (接口) ➔ Data Repository (实现) ➔ DataSource (Remote/Local)。

**DTO 与 Domain 隔离：**

RemoteDataSource 只负责调用 Retrofit API 并返回/接收 DTO，严禁出现 Domain 类型。

RepositoryImpl 是 DTO 与 Domain 的唯一转换边界。调用 DTO 的 `toDomain()` / `fromDomain()` 完成清洗后向上传递。

**数据库与网络隔离：**

业务 SQL 必须由具体 feature 的 `*_local_data_source.dart` 编写，Repository 不得直接拼接 SQL。

具体 feature 的 Retrofit API、DTO、RemoteDataSource 必须留在本 feature 的 `data/datasources/`，不得上提至 `core/network/`。

**组合根（DI）规则：**

本 feature 的 Repository Provider 统一在 `data/di/` 声明，返回值类型必须是 Domain 抽象接口。

ViewModel 只能通过 Provider 读取接口，严禁直接 import `data/repositories/*_impl.dart`。

**例外注记：**

`core/storage/app_config_dao.dart` 为全局保留的配置持久化组件，保持现状无需拆分。

### 2.2 Extension（扩展）物理归属

- `core/extensions/`：仅限与业务无关的纯技术工具扩展（如 `BuildContext.unfocus()`、`String.isUrl`）。
- `features/<feature>/data/models/`：DTO 的 `toDomain()` / `fromDomain()` 转换扩展。
- `features/<feature>/domain/models/`：Domain Entity 的纯业务计算扩展（纯 Dart，禁止 import UI 库）。
- `features/<feature>/presentation/extensions/`：Domain 状态到 UI 样式（Color、Icon、展示文案）的映射扩展。

---

## 3. Freezed 规范（Dart 3.13+ 原生主构造函数）

严禁使用旧版 `const factory Foo(...) = _Foo;`，必须使用主构造函数语法：

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

## 4. Few-Shot 标准代码范式

### 4.1 Riverpod ViewModel 范式

```dart
// presentation/viewmodels/example_view_model.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:agnes_ai_tester/src/features/example/data/di/example_data_providers.dart';
import 'package:agnes_ai_tester/src/features/example/presentation/viewmodels/example_state.dart';

part 'example_view_model.g.dart';

@riverpod
class ExampleViewModel extends _$ExampleViewModel {
  @override
  ExampleState build() => const ExampleState();

  // 纯业务校验 + 调 Repository，返回操作结果，绝不接收 BuildContext
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
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}
```

### 4.2 View 交互、监听与 Context 消费范式

```dart
// presentation/views/example_view.dart
// 仅展示核心交互：收起键盘、await 结果、mounted 校验、Context 跳转/弹窗
Future<void> _handleSubmit(
  BuildContext context,
  WidgetRef ref,
  TextEditingController controller,
) async {
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

### 4.3 Repository 协调与 DTO 转换范式

```dart
// domain/repositories/example_repository.dart
abstract interface class ExampleRepository {
  Future<ExampleItem> createItem(String title);
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
  Future<ExampleItem> createItem(String title) async {
    final dto = await _remote.create(title);
    await _local.save(dto);
    return dto.toDomain(); // ⭐ 在 Repository 统一将 DTO 清洗为 Domain 实体
  }
}
```

## 5. 开发与构建指令

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

## 6. AI 交付前自检清单（Pre-flight Checklist）

AI 在输出代码之前，必须确认：

- [ ] 零 Context 泄漏：ViewModel 中不存在任何 BuildContext 类型的参数或字段。
- [ ] 无 UI 库污染：ViewModel 所在文件没有引入 package:flutter/material.dart。
- [ ] 主构造函数语法：所有 Freezed 类均采用 `class Xxx({ ... }) with _$Xxx;`，没有使用 `abstract class + factory`。
- [ ] 分层不越界：View 仅与 ViewModel 通信；ViewModel 仅依赖 Repository 接口；数据转换在 Data 层就地消化。
- [ ] 生成声明完整：涉及代码生成的源文件均包含格式正确的 `part '*.g.dart';` 与 `part '*.freezed.dart';`。
