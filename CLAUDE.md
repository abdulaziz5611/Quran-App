# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get          # install/refresh dependencies
flutter run              # run on connected device/emulator
flutter analyze          # static analysis — must stay clean
flutter test             # run all tests (none authored yet)
flutter test test/path/to_test.dart -p "name pattern"   # single test
flutter clean && flutter pub get   # when build cache is stale
```

**Hot-restart caveat:** when class signatures change (especially constructors with required params being added/removed), the incremental kernel snapshot can hold stale references and the build will fail with errors that don't match the current source. Stop the app and cold-launch — don't keep hot-restarting.

## Architecture

Textbook clean architecture (Reso Coder-style) with **Cubit + GetIt + dartz**. Every feature is a vertical slice: `data/` (datasources, models, repository impl) → `domain/` (entities, abstract repository, use cases) → `presentation/` (cubit + state, pages, widgets). Adding a feature means creating that whole slice, not just a page.

### Folder layout

```
lib/
├── core/                    Framework primitives only — keep lean.
│   ├── error/               Failure (sealed) + Exception types.
│   └── usecase/             UseCase<T, P> base + NoParams.
├── config/app/              Cross-cutting nav shell (NOT a feature).
│   ├── theme/app_colors.dart
│   ├── const/{page_const,image_const}.dart
│   ├── splash/, navigation_screen/, more/, route/
├── features/<name>/
│   ├── data/{datasources,models,repositories}/
│   ├── domain/{entities,repositories,usecases}/
│   └── presentation/{cubit,pages,widgets}/
├── injection_container.dart   sl = GetIt.instance, init()
└── main.dart                  await di.init() before runApp
```

### Non-obvious conventions

**1. Cross-feature dependencies go through domain abstractions, never concrete impls.**
Example: `prayer_times.repository_impl` and `qibla.repository_impl` both depend on `LocationRepository` (a `domain/` abstract class from the `location` feature) — never on `LocationLocalDataSource` directly. This is what makes `location` swappable from hardcoded → `geolocator` without touching consumers.

**2. Third-party types are sealed inside `data/`.**
`adhan.Coordinates` exists only in `prayer_times/data/datasources/`. The repository converts our own `location.Coordinates` entity → `adhan.Coordinates` at the data-source boundary. **Don't leak third-party types past the data layer** — domain/entities and use cases must stay free of `package:adhan`, `package:hijri`, etc.

**3. `lib/config/app/` is the nav shell, not a feature.**
`MorePage` lives there because it's a navigation destination with no business logic — pure UI listing routes. Don't give it a clean-arch slice. New nav-shell pages (e.g. an "About" screen) go here too.

**4. Shared infrastructure features can have no UI.**
`features/location/` has no `presentation/` folder — it's a shared slice consumed by other features. This is intentional. Future shared concerns (e.g. a `notifications` feature) follow the same pattern.

### Wiring (must update together when adding a feature)

1. Create the slice (data + domain + presentation).
2. Add a `_initX()` helper inside `init()` in [injection_container.dart](lib/injection_container.dart). **Cubits** = `registerFactory` (fresh instance per `BlocProvider`); **everything else** (use cases, repository, data sources) = `registerLazySingleton` against the abstract type.
3. Add a const to [page_const.dart](lib/config/app/const/page_const.dart) and a `case` in [on_generate_route.dart](lib/config/app/route/on_generate_route.dart).
4. Add to [navigation_screen.dart](lib/config/app/navigation_screen/navigation_screen.dart) (bottom-nav tab) **or** [more_page.dart](lib/config/app/more/more_page.dart) (More-tab tile) — never both.
5. Pages instantiate their cubit via `BlocProvider(create: (_) => sl<XCubit>()..load())`.

### State convention

Cubit states are `Initial | Loading | Loaded | Error` and split into `<feature>_state.dart` as `part of '<feature>_cubit.dart'`. All state classes extend `Equatable`. Repository methods return `Future<Either<Failure, T>>` (`dartz`); cubits unwrap with `.fold(onError, onSuccess)`.

### Routing & navigation

`MaterialApp.onGenerateRoute = OnGenerateRoute.route`, `initialRoute = PageConst.splashPage`. Splash uses `pushReplacementNamed`. **Never use `Navigator.push(MaterialPageRoute(...))` directly** — always `Navigator.pushNamed(context, PageConst.x)`. The bottom nav uses `IndexedStack` to preserve cubit state across tab switches; do not change to `PageView` without preserving that behavior.

## Current state (2026-05-04)

**Built end-to-end:** home, prayer_times (uses `adhan`), location (hardcoded Mecca 21.4225, 39.8262), qibla_direction (great-circle bearing math + custom `QiblaCompass` widget).

**Stubs (just `Center(Text(...))`):** listen_quran, weather, settings.

**Bottom nav:** 4 tabs — Home · Quran · Qibla · More. The "More" page lists Weather, Settings, Support Us.

## Known follow-ups

- **Hardcoded Mecca location:** swap [`LocationLocalDataSourceImpl`](lib/features/location/data/datasources/location_local_data_source.dart) for a `geolocator`-backed impl. Only that file changes; needs Android `AndroidManifest.xml` + iOS `Info.plist` permission entries.
- **Live qibla compass:** wire `flutter_compass` heading stream into `QiblaCubit` so the dial rotates with device heading.
- **Prayer "remaining time" doesn't tick:** `_NextPrayerSection` in [home_page.dart](lib/features/home/presentation/pages/home_page.dart) computes once on build. Add `Timer.periodic(Duration(minutes: 1))` to refresh.
