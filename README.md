# Quran App

A Quran companion app for Android and iOS, built with Flutter. Alongside the Quran reader it handles the daily essentials — prayer times, the Hijri date, Qibla direction and bookmarks — so the app is useful throughout the day, not only while reading.

## Features

- **Quran reader** — surah browsing and reading with a resume-reading card on the home screen
- **Bookmarks** — save and return to any position
- **Prayer times** — calculated locally from device coordinates using the `adhan` library
- **Hijri calendar** — Islamic date shown alongside the Gregorian one
- **Qibla direction** — compass-based direction to the Kaaba
- **Location** — device location with a cached local data source, so prayer times work offline
- **Settings** — calculation method and app preferences
- **Home dashboard** — greeting, next prayer, daily quote and quick actions

## Tech Stack

| Layer | Choice |
| --- | --- |
| Framework | Flutter · Dart |
| State management | `flutter_bloc` (BLoC / Cubit) |
| Dependency injection | `get_it` |
| Functional error handling | `dartz` (`Either<Failure, T>`) |
| Value equality | `equatable` |
| Networking | `http` |
| Prayer times / Hijri | `adhan` · `hijri` · `intl` |
| Typography | `google_fonts` |

## Architecture

The project follows **Clean Architecture**, organised by feature rather than by layer:

```
lib/
├── config/          # theme, routes, splash, constants
├── core/            # shared errors, failures, base usecase
└── features/
    ├── bookmarks/
    ├── home/
    ├── location/
    ├── prayer_times/
    ├── qibla_direction/
    ├── quran_reader/
    ├── premium/
    └── settings/
```

Each feature is split into `domain` (entities, repositories, use cases), `data` (models, data sources, repository implementations) and `presentation` (BLoC, pages, widgets). Dependencies point inward — presentation depends on domain, never the reverse — which keeps business logic free of Flutter and testable in isolation.

## Getting Started

```bash
git clone https://github.com/abdulaziz5611/Quran-App.git
cd Quran-App
flutter pub get
flutter run
```

Requires the Flutter SDK (3.x) and a connected device or emulator. Location permission is needed for prayer times and Qibla direction.

## Roadmap

- Audio recitation with reciter selection
- Tafsir and translation toggles
- Prayer time notifications
