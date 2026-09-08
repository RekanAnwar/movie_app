<img src="assets/logos/app_icon.png" alt="MOVIE logo" width="96" />

# MOVIE

A Flutter app for browsing trending movies, searching titles, and saving a local watchlist and powered by the [TMDB API](https://developer.themoviedb.org).

---

## Features

- Browse trending, popular, now playing, upcoming, and top-rated movies
- Search movies by title
- Movie detail screen with overview and similar titles
- Local watchlist that persists offline (`shared_preferences`)
- Loading, empty, and network error states in the UI
- Null safety throughout

## State management

This project uses **[Riverpod](https://riverpod.dev)** (with `flutter_riverpod` / `hooks_riverpod`) for state management.


| Layer                 | Role                                              |
| --------------------- | ------------------------------------------------- |
| Providers / notifiers | UI state (home movies, search, watchlist, toasts) |
| Repositories          | API and local storage access                      |
| `Result` + Dio        | Networking and error mapping                      |


Riverpod keeps UI rebuilds scoped, makes dependencies injectable via providers, and fits cleanly with async TMDB calls (`FutureProvider`, `AsyncNotifier`, and family providers for paginated lists).

## Requirements

- Flutter **3.44.9** (Dart **3.12.2**) — use [FVM](https://fvm.app) or [Puro](https://puro.dev) to install and switch to this version
- A free [TMDB API](https://developer.themoviedb.org) access token



## Getting started



### 1. Clone the repository

```bash
git clone https://github.com/RekanAnwar/movie_app.git
cd movie_app
```



### 2. Use Flutter 3.44.9

With **FVM**

```bash
fvm install
fvm use
```

Or with **Puro**:

```bash
puro create movie_app 3.44.9
puro use 3.44.9
```



### 3. Install dependencies

```bash
flutter pub get
```



### 4. Configure the TMDB API key

1. Sign up at [developer.themoviedb.org](https://developer.themoviedb.org)
2. Create a `.env` file in the project root:

```env
ACCESS_TOKEN=your_tmdb_access_token_here
```



### 5. Run the app

```bash
flutter run
```



## Project structure

```text
lib/
  constants/     # Env, URLs, shared constants
  dependencies/  # Provider wiring
  mappers/       # JSON ↔ models
  models/        # Domain models
  pages/         # Home, search, watchlist, detail
  providers/     # Riverpod providers & notifiers
  repositories/  # TMDB + watchlist persistence
  themes/        # Light & dark Material themes
  utils/         # Networking helpers, extensions
  widgets/       # Reusable UI pieces
```



## Screens

1. **Home** — discover / trending and other movie sections
2. **Search** — find movies by title
3. **Watchlist** — locally saved titles (available offline)
4. **Detail** — overview, watchlist toggle, similar movies



## Offline support

The watchlist is stored with `**shared_preferences**`, so saved movies remain available when the device is offline.
