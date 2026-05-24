# 📱 Catchy — Social Media App

A Flutter-based social media application with offline-first architecture using Hive for local storage, BLoC for state management, and support for image/video posts.

---

## 🚀 Features

- Create posts with images and videos
- Audience visibility control (Public / Friends / Only Me)
- Like / Unlike posts
- Feed screen with all saved posts
- Offline-first — all data stored locally with Hive
- Permanent media storage (temp → app documents)

---

## 🗂️ Folder Structure

```
social_media/
├── android/
│   └── app/
│       └── src/main/AndroidManifest.xml
├── assets/
│   ├── images/
│   └── videos/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── widget/
│   │   │   ├── post_widget.dart
│   │   │   └── profile_avatar.dart
│   │   └── service/
│   │       └── file_storage_service.dart
│   └── features/
│       ├── create_post/
│       │   ├── bloc/
│       │   │   ├── create_post_bloc.dart
│       │   │   ├── create_post_event.dart
│       │   │   └── create_post_state.dart
│       │   ├── data/
│       │   │   ├── post_media.dart
│       │   │   └── hive_model/
│       │   │       ├── post_hive_model.dart
│       │   │       ├── post_hive_model.g.dart
│       │   │       ├── post_media_hive.dart
│       │   │       └── post_media_hive.g.dart
│       │   ├── repository/
│       │   │   └── post_repository.dart
│       │   ├── service/
│       │   │   └── media_picker_service.dart
│       │   └── presentation/
│       │       ├── preview_screen.dart
│       │       └── audience_screen.dart
│       └── feed/
│           ├── bloc/
│           │   ├── feed_bloc.dart
│           │   ├── feed_event.dart
│           │   └── feed_state.dart
│           ├── data/
│           │   └── models/
│           │       ├── post_model.dart
│           │       └── media_info.dart
│           ├── repository/
│           │   └── feed_repository.dart
│           └── presentation/
│               └── feed.dart
├── pubspec.yaml
└── README.md
```

---

## 🧱 Architecture

This project follows **Feature-first Clean Architecture** with BLoC pattern.

```
Presentation  →  BLoC  →  Repository  →  Hive / FileStorage
```

Each feature is self-contained with its own bloc, data, repository, and presentation layers.

---

## 📦 Dependencies

### Runtime

| Package | Version | Purpose |
|---|---|---|
| `flutter_bloc` | ^9.1.1 | State management |
| `bloc` | ^9.2.1 | Core BLoC library |
| `hive` | ^2.2.3 | Local NoSQL database |
| `hive_flutter` | ^1.1.0 | Hive Flutter integration |
| `video_player` | ^2.10.1 | Play videos in feed |
| `file_picker` | ^10.3.2 | Pick images and videos |
| `ffmpeg_kit_flutter_new` | ^4.1.0 | Video thumbnail generation |
| `path_provider` | ^2.1.5 | App document directory for permanent storage |
| `uuid` | ^4.5.3 | Generate unique post IDs |
| `cached_network_image` | ^3.4.1 | Network image caching |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

### Dev Dependencies

| Package | Version | Purpose |
|---|---|---|
| `hive_generator` | ^2.0.1 | Generate Hive TypeAdapters |
| `build_runner` | ^2.4.9 | Code generation runner |
| `flutter_lints` | ^5.0.0 | Lint rules |

---

## ⚙️ Setup & Installation

### 1. Clone the repository
```bash
git clone https://github.com/nareshgupta99/social_media.git
cd social_media
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate Hive adapters
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app
```bash
flutter run
```

---

## 🗄️ Hive Models

### `PostHiveModel` — typeId: 0

| Field | HiveField | Type |
|---|---|---|
| id | 0 | String |
| medias | 1 | List\<PostMediaHive\> |
| caption | 2 | String? |
| visibility | 3 | String |
| createdAt | 4 | DateTime |
| isLike | 5 | bool |

### `PostMediaHive` — typeId: 1

| Field | HiveField | Type |
|---|---|---|
| path | 0 | String |
| mediaType | 1 | String |
| thumbnailPath | 2 | String? |

---

## 🔄 Data Flow

### Create Post
```
User picks media (temp path)
    → FileStorageService.saveFile()     copy to permanent storage
    → Future.wait(medias.map(...))      convert to PostMediaHive
    → PostHiveModel(...)                build model
    → PostRepository.savePost()         save to Hive box
    → state.saved = true                navigate to Feed
```

### Feed
```
FeedScreen opens
    → LoadFeedEvent
    → FeedBloc._onLoadFeed()
    → PostRepository.getAllPosts()
    → Hive.openBox('posts').values
    → FeedState(posts: [...])
    → ListView.builder → PostWidget
```

### Like / Unlike
```
User taps like
    → postLikeEvent(id, isLike)
    → find post by id in Hive
    → post.isLike = event.isLike
    → post.save()                       HiveObject built-in save
    → reload posts → emit updated state
```

---

## 📋 Android Permissions

```xml
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
    android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
    android:maxSdkVersion="29"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

---

## 🛠️ Code Generation

After adding or modifying any `@HiveType` model, re-run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Make sure every Hive model has:
- `part 'filename.g.dart';` directive
- `@HiveType(typeId: uniqueId)` annotation
- `@HiveField(index)` on every field to be stored

---

## 📌 Notes

- `typeId` must be unique across the entire app
- Register child adapters before parent adapters in `main.dart`
- Media files are copied from temp cache to `getApplicationDocumentsDirectory()/posts/media/` for permanent storage
- `post.save()` works because `PostHiveModel extends HiveObject`
