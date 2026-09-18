# Flutter MVVM + Repository 应用架构搭建指南

> **用途**：这是与具体产品无关的 Codex 输入模板。将本文件连同新项目的业务需求交给 Codex，即可按一致的分层、命名和工程约定搭建 Flutter 项目骨架。
>
> **默认技术栈**：状态管理使用 [Riverpod](https://pub.dev/packages/riverpod) / `flutter_riverpod`，路由使用 [go_router](https://pub.dev/packages/go_router)，网络请求使用 [Dio](https://pub.dev/packages/dio)。这些是默认值，不是不可替换的硬约束；若新项目已有明确技术栈，Codex 应遵循新项目约束并记录偏差。
>

## 1. 目标与原则

采用**按功能组织（feature-first）+ 功能内分层**的 MVVM + Repository 架构。目标不是机械地为每个文件创建四层，而是让每个职责只有一个明确的位置：

```text
Widget / Screen ──用户事件──> Controller（ViewModel） ──> Repository ──> API / DB / Local Storage
       ▲                              │                         │
       └──── 状态管理库的订阅接口 ───── Application Service ┘
```

核心规则：

- **Presentation（View）** 只处理渲染、表单输入、导航和调用 Controller；不直接编写持久化业务。
- **Controller（ViewModel）** 保存会影响界面的操作状态（具体状态类型由所选状态管理方案决定），编排一次用户动作，并通过 Repository / Service 执行。
- **Repository（Model 的数据访问边界）** 封装数据源、查询、序列化、CRUD 和实时监听；UI 不应知道具体 SDK 调用细节。
- **Domain** 放不依赖 Flutter、状态管理库或具体数据源的业务实体、值对象、类型别名和纯计算。
- **Application Service** 仅在业务需要协调两个以上 Repository、组合多个流或执行跨实体用例时引入；简单 CRUD 不必额外创建 Service。
- **状态管理/DI 方案**只负责状态订阅和依赖装配，不把它当作第二套业务层。
- 依赖方向只能从外向内：`presentation → application/data → domain`；`domain` 不得导入 Flutter、Firebase 或 Riverpod。

## 2. 默认技术选型与替换策略

架构要求的是“状态、导航、依赖、网络和数据源有清晰边界”。默认采用下列实现：

| 能力 | 默认实现 | 主要职责 |
| --- | --- | --- |
| 状态管理与依赖注入 | Riverpod + `flutter_riverpod` | Provider 图、ViewModel/Notifier、异步状态、测试覆盖 |
| 状态代码生成 | `riverpod_annotation` + `riverpod_generator` | 生成类型安全 Provider（按需启用） |
| 路由 | `go_router` | 声明式路由、命名路由、深链接、认证 redirect、嵌套导航 |
| 网络请求 | `dio` | Base URL、超时、请求/响应拦截器、取消、错误归一化 |
| 模型生成 | `freezed` + `json_serializable`（按需） | 不可变状态、联合类型、JSON 映射 |
| 本地存储 | `shared_preferences` / `sqflite` / `drift`（按需） | 轻量设置、缓存或关系型本地数据 |

替换规则：

1. 先检查新项目现有的 `pubspec.yaml`、`AGENTS.md`、代码和用户明确指定的技术栈。
2. 用户明确指定的库优先；已有工程中已经使用的库不要无理由替换。
3. 用户没有指定时，使用上表默认方案；只安装实际需要的包，不复制来源工程的全部依赖。
4. 若必须改用其他方案，保留相同的接口和依赖方向，并记录替换理由、影响和迁移边界。

可替换位置：

| 能力 | 可选实现示例 | 统一要求 |
| --- | --- | --- |
| 状态管理 / DI | 默认 Riverpod；也可用 Bloc/Cubit、Provider、GetX、ChangeNotifier 等 | View 不持有数据源；Controller/Notifier 有明确输入、状态和命令；依赖可测试替换 |
| 路由 | 默认 go_router；也可用 auto_route、Beamer、Navigator 2.0、原生 Navigator | 路由集中管理；页面不散落硬编码路径；认证/引导重定向可测试 |
| 异步状态 | 所选状态包的 AsyncState、Cubit state、sealed class 等 | 至少覆盖 loading、error、empty、data、操作成功/失败 |
| 依赖注入 | Provider、get_it、手动构造、构造函数注入等 | Repository 可通过 Mock/Fake 替换；不在业务类中获取全局容器 |
| 网络 | 默认 Dio；也可用 `package:http`、Chopper、GraphQL 客户端等 | 客户端、拦截器、超时和错误映射不进入 ViewModel/Widget |
| 数据源 | REST、GraphQL、SQLite/Drift、Isar、Firebase、内存 Fake 等 | SDK 调用和映射收敛在 data/infrastructure 层 |

默认使用 Riverpod、go_router 和 Dio；若用户未指定其他方案，Codex 应直接采用它们。若用户指定替代方案，将相同职责映射到该方案，不要同时引入两套状态管理、路由或网络客户端。

默认最小依赖基线（版本以创建新项目当天的兼容矩阵为准，不要盲目复制旧锁定版本）：

```yaml
dependencies:
  riverpod: any                  # 核心 Provider API（非 Widget 层需要时）
  flutter_riverpod: any
  riverpod_annotation: any       # 使用 Generator 时
  go_router: any
  dio: any

dev_dependencies:
  build_runner: any              # 使用代码生成时
  riverpod_generator: any        # 使用 @riverpod 时
  riverpod_lint: any
  custom_lint: any
  flutter_test:
    sdk: flutter
```

`freezed`、`json_serializable`、`easy_localization`、`shared_preferences`、`sqflite/drift`、`connectivity_plus` 等仅在需求明确时添加。

来源工程 `starter_architecture_flutter_firebase` 中的对应实现可参考（仅用于理解，不是新项目约束）：

| 架构职责 | 来源工程文件 |
| --- | --- |
| 入口与应用壳 | `lib/main.dart`、`lib/src/app.dart` |
| 路由和全局启动 | `lib/src/routing/` |
| 领域模型 | `features/jobs/domain/job.dart`、`features/entries/domain/entry.dart` |
| 聚合业务 Service | `features/entries/application/entries_service.dart` |
| ViewModel / Controller | `presentation/**/**_controller.dart` |
| View / Screen | `presentation/**/*_screen.dart` |

## 3. 推荐目录结构

新项目从下面结构开始。`feature_name` 使用 `snake_case`，每个功能独立自包含；不要按全局 `screens/`、`models/`、`services/` 大目录拆散同一业务。

```text
lib/
├── main.dart                         # 平台初始化、启动应用、依赖根
└── src/
    ├── app.dart                       # 应用壳、主题、全局包装
    ├── routing/                       # 默认使用 go_router 的集中路由配置
    │   ├── app_router.dart            # AppRoute、redirect、导航键
    │   ├── app_startup.dart           # 异步启动门控
    │   └── not_found_screen.dart
    ├── core/                          # 跨功能基础设施（按需创建）
    │   ├── network/
    │   │   ├── api_client.dart        # 默认 Dio 单例与拦截器
    │   │   └── api_exception.dart     # 统一网络异常
    │   ├── config/                    # 环境变量与运行时配置
    │   ├── storage/                   # SharedPreferences/SQLite/Drift
    │   └── connectivity/              # 离线状态（需要时）
    ├── constants/                     # 设计常量、断点、键、非本地化字符串
    ├── localization/                  # 本地化扩展或 l10n 配置
    ├── common_widgets/                # 跨功能且无业务语义的可复用组件
    ├── theme/                         # 主题、颜色、排版
    ├── utils/                         # 格式化、校验、对话框、异步状态 UI
    └── features/
        └── feature_name/
            ├── domain/
            │   ├── feature_entity.dart
            │   └── feature_types.dart             # 可选：FeatureId 等
            ├── data/
            │   ├── feature_repository.dart
            │   ├── feature_data_source.dart       # 可选
            │   └── feature_mapper.dart             # 复杂映射时使用
            ├── application/                        # 可选：跨 Repository 的用例
            │   └── feature_service.dart
            └── presentation/
                ├── feature_list/
                │   ├── feature_list_screen.dart
                │   └── feature_list_controller.dart
                └── edit_feature/
                    ├── edit_feature_screen.dart
                    └── edit_feature_controller.dart
```

说明：

- 小功能可以没有 `application/`，也可以只有一个 `presentation/feature_screen.dart`。
- 与页面强绑定的 Controller 放在对应 `presentation/<screen_name>/` 旁边；若是跨多个页面的用例，放入 `application/`。
- 代码生成文件（例如 `*.g.dart`）只在所选工具需要时创建；由生成器维护，禁止手工编辑，并按团队约定决定是否提交。
- 不要将一个 feature 的实体、Repository 或 Controller 从另一个 feature 的 `presentation` 中反向导入；需要共享的业务抽到新的 feature/domain 或 application 边界。

## 4. 各层的实施规范

### 4.1 Domain：业务事实和纯逻辑

领域实体应尽量不可变，使用 `Equatable` 或 Dart 原生相等性。数据源映射仅在项目较小且追求精简时可放在实体中；复杂项目建议额外使用 Data Model / DTO，转换发生在 Repository 内，避免 SDK 字段渗入 Domain。

```dart
typedef ProjectId = String;

class Project extends Equatable {
  const Project({required this.id, required this.name});

  final ProjectId id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
```

Domain 中适合放：实体、值对象、枚举、纯函数、领域校验和领域异常。不要放：`BuildContext`、`Widget`、具体数据源 SDK、全局容器或 UI 状态对象。

### 4.2 Data：Repository 和数据源

一个 Repository 对应一个数据聚合/资源，构造函数接收数据源，因此可在测试中传入 Mock 或 Fake。所有具体数据源的查询、路径、转换和写入必须收敛在此层。

```dart
abstract interface class ProjectsRepository {
  Stream<List<Project>> watchAll({required String userId});
  Future<Project?> getById({required String userId, required ProjectId id});
  Future<void> create({required String userId, required Project project});
  Future<void> update({required String userId, required Project project});
  Future<void> delete({required String userId, required ProjectId id});
}
```

依赖注入和生命周期：

- SDK 单例、Repository 和应用级配置应由依赖根装配，并明确生命周期。
- 与页面/参数绑定的查询、流和 Controller 通常在页面离开后释放，长期缓存必须有明确理由。
- 依赖从构造函数、Provider、DI 容器或所选框架的等价机制获取；禁止在 Repository 内自己读取全局容器或调用 UI。
- 需要用户身份时，由认证用例明确提供 `userId`；未登录应返回清晰错误，不能静默写入公共数据。

### 4.3 Application：组合用例

当一个页面需要“订单流 + 商品流”合成为报表，或一个写操作涉及多个 Repository 时，建立 Service。Service 不认识 Widget；它接收 Repository，并输出领域对象或 View Model。

来源工程 `starter_architecture_flutter_firebase` 的 `EntriesService` 使用 `CombineLatestStream.combine2` 组合 entries 与 jobs，再生成报表显示模型，是此层的范例。

```dart
class ProjectDashboardService {
  const ProjectDashboardService({
    required this.projectsRepository,
    required this.tasksRepository,
  });

  final ProjectsRepository projectsRepository;
  final TasksRepository tasksRepository;

  Stream<List<ProjectDashboardItem>> watchDashboard(UserID uid) {
    // 在这里组合、过滤、聚合；不要让 Screen 自己拼装两个数据源。
  }
}
```

### 4.4 Presentation：View 和 Controller（ViewModel）

Screen 读取数据、渲染三态、监听副作用并把点击事件转给 Controller。下面的代码是本指南默认 Riverpod 的一种写法；若新项目明确覆盖默认方案，应使用等价的 Notifier/Cubit/Store。

```dart
part 'edit_project_controller.g.dart';

@riverpod
class EditProjectController extends _$EditProjectController {
  @override
  FutureOr<void> build() {}

  Future<bool> submit({Project? original, required String name}) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) throw StateError('Sign-in is required');

    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(projectsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      if (original == null) {
        await repository.create(uid: user.uid, name: name);
      } else {
        await repository.update(
          uid: user.uid,
          project: original.copyWith(name: name),
        );
      }
    });
    return !state.hasError;
  }
}
```

View 的使用约定（以 Riverpod 示例命名的 `watch/read/listen`，其他库映射到对应 API）：

- 用状态管理库的订阅 API 获取会影响渲染的数据或命令状态。
- 用状态管理库的命令 API 触发按钮点击、保存、删除等一次性动作。
- 用状态变化监听机制显示错误对话框、Toast、跳转等副作用；不要在 `build` 内直接导航或弹框。
- 使用所选方案的异步状态组件或统一列表组件，始终提供 loading / error / empty / data 状态。
- 提交成功后由 Screen 判断 `mounted` 再执行导航；导航名称统一来自集中路由配置，禁止散落硬编码 URL。
- `TextEditingController` 必须存为 `State` 字段并在 `dispose` 释放，不能在 `build` 中反复创建。

## 5. Riverpod 状态管理与代码生成（默认）

默认使用 [Riverpod](https://pub.dev/packages/riverpod) / `flutter_riverpod`：Provider 负责依赖装配和响应式订阅，`Notifier` / `AsyncNotifier` 负责可变业务状态和用户命令。Riverpod 官方建议用 `(Async)NotifierProvider` 集中管理会因用户交互而变化的状态；本指南将它作为 MVVM 的 ViewModel 实现。

推荐用法：

| 情况 | Riverpod 写法 | 作用 |
| --- | --- | --- |
| 应用级同步依赖 | `@Riverpod(keepAlive: true) Type dep(Ref ref)` | Dio、Repository、配置等单例 |
| 异步初始化 | `@riverpod Future<T> dep(Ref ref)` | SharedPreferences、数据库、远程配置 |
| 带参数读取 | `@riverpod Stream<T> watch(Ref ref, Id id)` | 页面/实体级查询（默认 auto-dispose） |
| 页面命令状态 | `@riverpod class XxxViewModel extends _$XxxViewModel` | `AsyncNotifier` 的 loading/error/data 和命令 |
| 轻量本地状态 | `@riverpod class Xxx extends _$Xxx` | 主题、Tab、筛选器等不可变状态 |

示例：

```dart
part 'edit_project_view_model.g.dart';

@riverpod
class EditProjectViewModel extends _$EditProjectViewModel {
  @override
  FutureOr<void> build() {}

  Future<bool> submit(Project project) async {
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(projectsRepositoryProvider);
    state = await AsyncValue.guard(() => repository.update(project));
    return !state.hasError;
  }
}
```

View 使用 `ref.watch` 获取渲染数据，`ref.read(...notifier)` 触发命令，`ref.listen` 处理错误对话框、Toast 和导航等副作用。通过 `.select` 只订阅页面需要的字段，避免不必要的重建。

新增、移动或修改注解文件后执行：

```bash
dart run build_runner build --delete-conflicting-outputs
```

开发时可改用 `dart run build_runner watch --delete-conflicting-outputs`。`*.g.dart`、`*.freezed.dart` 等生成文件不得手工编辑；是否提交按团队策略决定。若新项目明确要求其他状态管理方案，可以替换 Riverpod，但必须保留相同的 ViewModel、Repository、依赖注入和测试边界，不要同时引入两套状态管理。

测试优先使用 `ProviderScope(overrides: [...])` 覆盖 Repository/Dio Provider；也可直接用构造函数注入 Mock/Fake。优先测试领域映射/纯逻辑、Repository 请求、ViewModel 成功与失败状态、关键路由重定向。

## 6. Dio + Retrofit 网络层（默认）

默认使用 [Dio](https://pub.dev/packages/dio) 配合 [Retrofit for Dart](https://pub.dev/packages/retrofit)。Dio 配置与通用客户端限制在 `core/network/`；Retrofit API、业务 DTO 和 RemoteDataSource 必须按 feature 放在 `features/<feature>/data/datasources/`。RemoteDataSource Provider 与对应数据源放在同一个文件，Repository Provider 放在本 feature 的 `data/di/`。Dio 官方文档建议在应用中复用一个配置统一的实例，而不是在每个 Repository 或页面中 `Dio()`。

Retrofit 负责声明式 endpoint 合约，Freezed + `json_serializable` 负责请求/响应 DTO。推荐的数据流为：

```text
DioApiClient(core/network) -> Feature data/datasources RemoteDataSource Provider -> RemoteDataSource
AppDatabase(core/storage) -> Feature data/datasources LocalDataSource(SQL)
AppConfigDao(core/storage) -> AppConfig persistence (existing exception)
Remote/Local DataSource -> data/repositories Repository 实现 -> data/di Repository Provider -> Domain Repository
```

其中 `DioApiClient` 只负责 Base URL、超时、鉴权、日志和 `DioException` 归一化，不能依赖任何 feature 类型；Retrofit API 不应被 ViewModel 直接调用；RemoteDataSource 负责 DTO 与领域模型之间的转换，以及对 OpenAI 兼容字段的兼容处理。

推荐结构：

```text
lib/src/core/network/
├── api_client.dart         # Dio 单例、BaseOptions、鉴权、异常
├── api_exception.dart      # Timeout/Unauthorized/Server/Network 等领域无关错误
├── agnes_dio_log_interceptor.dart
└── interceptors/
    ├── auth_interceptor.dart
    ├── logging_interceptor.dart
    └── error_interceptor.dart
```

Feature 网络数据源示例：

```text
lib/src/features/chat/data/datasources/
├── chat_api.dart                 # ChatApi Retrofit endpoint
├── chat_api_models.dart          # Chat DTO（Freezed + JSON）
└── chat_remote_data_source.dart  # DTO -> Domain 边界映射
```

```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = Dio(
    BaseOptions(
      baseUrl: ref.watch(apiBaseUrlProvider),
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
  client.interceptors.addAll([
    AuthInterceptor(ref),
    if (kDebugMode) LoggingInterceptor(),
    ErrorInterceptor(),
  ]);
  return client;
}
```

网络层规则：

- Base URL、超时、默认 headers 和环境变量集中配置；生产环境不把 token/密钥写死在源码。
- Logging 只在 debug 或经过脱敏后启用，禁止输出 Authorization、密码和个人敏感数据。
- Interceptor 负责 token 注入、刷新、日志和把 `DioException` 归一化；不要在 Widget 捕获 Dio 异常。
- Retrofit API 可以暴露类型化的 `Future<T>` endpoint，但 Repository 必须通过 RemoteDataSource 完成 DTO 到 Domain 的转换，不能把 `Response`、DTO 或 JSON Map 传给 ViewModel。
- 统一映射连接超时、无网络、取消、401/403、404、业务错误和 5xx；保留原始 cause/stack，给 UI 暴露可读的 AppException。
- 写操作支持取消、幂等键（需要时）、重试白名单和分页；不要自动重试非幂等请求。
- Dio Provider、ApiClient 和 Repository 都要能通过 `ProviderScope` override 或构造函数注入替换。

Repository 的典型调用链：`View → ViewModel → FeatureRepository → RemoteDataSource → Retrofit(Dio) → DTO/Mapper → Domain`。

## 7. 应用启动、认证和路由（默认 go_router）

### 启动顺序

`main.dart` 的推荐顺序：

1. `WidgetsFlutterBinding.ensureInitialized()`。
2. 注册全局 Flutter / Platform 错误处理。
3. 初始化项目实际选择的数据源和基础设施（没有就跳过）。
4. 用项目选择的依赖根启动应用；默认 Riverpod 使用 `ProviderScope`，可配置 `ProviderObserver` 统一记录 Provider 生命周期和异常。

不要将尚未完成的异步依赖直接用于路由。用 `AppStartupState` 或所选状态库的等价机制等待本地设置、远程配置、迁移和认证恢复；它负责展示 loading、失败和 retry，再构建真正的路由树。

### 认证边界

- 认证 SDK 通过 `AuthRepository` 或等价接口封装，向上暴露当前用户、状态流和认证命令。
- 路由守卫订阅认证状态变化，并在状态变化时刷新重定向。
- redirect 至少覆盖三态：未完成引导、未登录、已登录后访问登录/引导页。
- 私有数据必须有服务端授权边界；客户端的 `userId` 路径约定不能替代服务端安全规则。

### 路由约定

默认在 `src/routing/` 集中维护 [go_router](https://pub.dev/packages/go_router) 配置；若项目指定其他库，再将这些职责映射到对应目录和 API：

- 用 `AppRoute` 枚举、常量或类型安全路由对象作为命名路由的单一来源。
- 页面跳转使用 `context.goNamed` / `pushNamed` 等命名 API，参数由集中配置声明。
- 用 `redirect` 和认证状态监听实现引导、登录和受保护页面守卫；守卫不能直接操作 Widget。
- 有底部导航/侧栏且需要保持 Tab 栈时，使用 `StatefulShellRoute` 或等价的分支导航状态。
- 编辑、创建等全屏弹窗使用 root navigator；未知地址配置 `errorBuilder` / `errorPageBuilder`。
- 分支路由不要散落在页面文件中，路径、参数、页面实例和转场应集中维护。

## 8. 可选数据源扩展

默认模板不绑定任何后端或数据库。新项目按需求选择 REST、GraphQL、SQLite/Drift、Isar、内存 Fake 等数据源，并将 SDK 调用收敛在 Repository/Infrastructure 层。

## 9. 新功能落地清单

以 `projects` 功能为例，按以下顺序实现：

1. 在 `domain/` 建立不可变 `Project`、`ProjectId`，并先写纯逻辑单测。
2. 在 `data/` 建立 `ProjectsRepository`：定义查询、映射、单次读取、实时流和写操作；提供可替换的构造入口。
3. 只有在需要跨资源计算时，创建 `application/ProjectsService` 或 Use Case。
4. 在 `presentation/` 创建 Screen 和所选状态管理方案的 Controller/Notifier/Cubit。读取数据订阅状态，保存/删除等命令由 Controller 管理异步状态。
5. 将路由名、参数和守卫加入集中导航配置；不要在页面中硬编码 URI。
6. 为 loading、empty、error、成功跳转和未登录分别提供可验证的行为。
7. 只有项目使用代码生成器时才运行对应生成命令，然后执行格式化、静态分析和测试。
8. 根据所选数据源更新授权规则、索引/迁移和 CI Secrets；不要为未选用的后端添加配置。

## 10. 两个来源工程的综合记录与迁移注意事项

以下信息综合自两个仓库：`starter_architecture_flutter_firebase` 与 `flutter_mvvm_riverpod`，**仅用于解释本指南的来源，不是新项目必须复制的代码**：

### `starter_architecture_flutter_firebase` 的可复用经验

- 入口为 `lib/main.dart`，先完成基础设施初始化，再以 Riverpod `ProviderScope` 启动 `lib/src/app.dart`。
- 功能包括 `authentication`、`onboarding`、`jobs`、`entries`，功能内按 `domain/data/application/presentation` 组织。
- Riverpod Generator 用于依赖和页面 Controller；`entries/application/entries_service.dart` 演示跨 Repository 组合实时流。
- GoRouter 使用 `StatefulShellRoute.indexedStack`、独立 branch navigator 和认证流 redirect，适合需要保留 Tab 栈的应用。
- 部分实体直接实现 `fromMap/toMap`；复杂项目应把 DTO/Mapper 留在 data 层。
- 删除 Job 会逐条删除关联 Entry 后再删除 Job；真实项目应根据一致性要求考虑批量写入、事务、Cloud Function 或软删除。

### `flutter_mvvm_riverpod` 的可复用经验

- 以 `lib/features/<feature>/` 聚合功能；常见子目录为 `model`、`repository`、`ui/state`、`ui/view_model`、`ui/widgets`，可映射为本指南的 `domain`、`data`、`presentation`。
- 通过 `@Riverpod` + `AsyncNotifier` 实现 ViewModel，使用 `Freezed` / `json_serializable` 生成不可变状态和 JSON 映射；适合复杂表单、认证、个人资料和订阅状态。
- `features/common/remote/api_client.dart` 集中创建 Dio、BaseOptions、超时和拦截器，并将 Dio 异常映射为 Timeout/Unauthorized/Server 等可读异常。
- `features/common/local/database_provider.dart` + `sqflite` 提供本地缓存；Repository 同时协调远程 API 和本地数据库，适合离线优先或缓存场景。
- `environment/env.dart` + `envied` 读取环境变量；`OfflineContainer`、全局 Loading、主题和 `easy_localization` 展示了跨功能基础设施的放置方式。
- GoRouter 路由集中在 `lib/routing/router.dart` 与 `routes.dart`，并封装自定义转场；新项目仍应补充认证 redirect、深链接和路由测试。
- 该仓库包含 Supabase、RevenueCat、Google/Apple 登录等可选集成，并留有 fake/TODO 分支；新项目只复制经过验证的边界，不复制临时数据或未完成分支。

## 11. 交给 Codex 的实施指令（可直接复制）

将以下内容与产品需求一起发给 Codex；方括号内容替换为项目实际信息。

```text
请在当前 Flutter 工作区搭建并实现 [项目/功能名称]，遵循《FLUTTER_MVVM_REPOSITORY_BOOTSTRAP.md》的职责边界和验收标准。

项目需求：
- 功能：[功能清单、实体、页面、数据源、验收标准]
- 是否需要登录：[是/否；认证方式]
- 状态管理：[用户指定的库；未指定默认使用 Riverpod]
- 路由管理：[用户指定的库；未指定默认使用 go_router]
- 网络请求：[用户指定的库；未指定默认使用 Dio]
- 依赖注入：[指定方案或“构造函数注入即可”]

实施要求：
1. 先读取现有 pubspec.yaml、AGENTS.md 和工作区改动；不要覆盖无关用户改动。
2. 使用 feature-first 目录；每个功能内按 domain / data / application（仅需要时）/ presentation 分层。
3. Domain 不依赖 Flutter、状态管理包或具体数据源 SDK；Repository 封装全部数据访问和映射。
4. 每个写操作通过对应 ViewModel/Controller/Notifier/Cubit 管理异步状态；View 只渲染、收集输入、监听副作用和导航。
5. 严格使用上方选择的状态管理、路由、网络、DI 和代码生成方案；没有明确覆盖时使用 Riverpod、go_router 和 Dio，不要同时引入两套同类库。
6. 集中维护路由、参数、认证/引导守卫、未知路由和所需的嵌套导航；不要在页面中散落硬编码路径。
7. 实现 loading、error、empty、data、未登录、成功和重复提交保护。
8. 为 Domain、Repository、Controller 和关键路由补充有价值的测试，并隔离真实外部服务。
9. 完成后运行适用于实际技术栈的 format、生成（如有）、analyze 和 test 命令，报告命令结果、变更目录和剩余配置项。

请直接实现，不要只给方案。若需求与现有工程约束冲突，先指出冲突并采用用户明确选择；不要把本文来源工程的插件或 Firebase 配置当作默认值。
```

## 12. 验收命令与参考资料

以下命令按实际技术栈执行；代码生成命令只在项目使用对应生成器时运行：

```bash
dart format lib test
flutter analyze
flutter test
```

若使用代码生成器，再执行该工具的生成命令，例如 Riverpod/Freezed 常见的：

```bash
dart run build_runner build --delete-conflicting-outputs
```

架构和默认包的参考资料：

- [Flutter 官方应用架构指南](https://docs.flutter.dev/app-architecture/guide)：Views、ViewModels、Repositories、Services、可选 Domain 层。
- [Flutter 官方架构建议](https://docs.flutter.dev/app-architecture/recommendations)：关注点分离、Repository 单一事实来源、抽象 Repository、可测试性。
- [Riverpod](https://pub.dev/packages/riverpod) 与 [`(Async)NotifierProvider` 文档](https://riverpod.dev/docs/providers/notifier_provider)：默认状态管理和用户命令状态。
- [go_router](https://pub.dev/packages/go_router)：默认声明式、深链接、redirect、Shell/嵌套路由方案。
- [Dio](https://pub.dev/packages/dio)：默认 HTTP 客户端、BaseOptions、超时、拦截器和取消请求。
