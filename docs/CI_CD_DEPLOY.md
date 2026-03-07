# CI/CD и Deploy — LT Fest Mobile

Полная инструкция по настройке непрерывной интеграции, сборки и публикации приложения LT Fest.

---

## Содержание

1. [Предварительные требования](#1-предварительные-требования)
2. [Локальная подготовка к релизу](#2-локальная-подготовка-к-релизу)
3. [GitHub Actions CI/CD](#3-github-actions-cicd)
4. [Deploy в Google Play](#4-deploy-в-google-play)
5. [Deploy в App Store](#5-deploy-в-app-store)
6. [Huawei AppGallery](#6-huawei-appgallery)
7. [Чеклист перед релизом](#7-чеклист-перед-релизом)

---

## 1. Предварительные требования

### Обязательно

- **Flutter SDK** ≥ 3.3.0
- **Git** и репозиторий (GitHub/GitLab)
- **Android**: JDK 17, Android SDK
- **iOS**: Xcode (только на macOS), Apple Developer Account
- **Firebase**: проект с `google-services.json` (Android) и `GoogleService-Info.plist` (iOS)

### Секреты и ключи

| Название | Где используется | Описание |
|----------|------------------|----------|
| `KEYSTORE_BASE64` | Android | Base64-encoded keystore для подписи |
| `KEYSTORE_PASSWORD` | Android | Пароль keystore |
| `KEY_ALIAS` | Android | Алиас ключа |
| `KEY_PASSWORD` | Android | Пароль ключа |
| `APP_STORE_CONNECT_API_KEY` | iOS | API Key для App Store Connect |
| `MATCH_PASSWORD` | iOS | Пароль для fastlane match (если используется) |
| `SENTRY_AUTH_TOKEN` | Оба | Токен Sentry для загрузки символов |

---

## 2. Локальная подготовка к релизу

### 2.1 Обновление версии

В `pubspec.yaml`:

```yaml
version: 0.2.2+27  # формат: major.minor.patch+buildNumber
```

- `0.2.2` — версия для пользователей
- `27` — build number (должен расти при каждой сборке)

### 2.2 Генерация кода

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### 2.3 Проверка перед сборкой

```bash
flutter analyze lib
flutter test
```

### 2.4 Сборка Android (локально)

1. Создайте `android/key.properties`:

```properties
storePassword=ВАШ_ПАРОЛЬ
keyPassword=ВАШ_ПАРОЛЬ
keyAlias=ВАШ_АЛИАС
storeFile=путь/к/upload-keystore.jks
```

2. Соберите APK/AAB:

```bash
# AAB для Google Play (рекомендуется)
flutter build appbundle --release

# APK для тестирования
flutter build apk --release
```

Результат:
- AAB: `build/app/outputs/bundle/release/app-release.aab`
- APK: `build/app/outputs/flutter-apk/app-release.apk`

### 2.5 Сборка iOS (только macOS)

1. Настройте подпись в Xcode (Signing & Capabilities)
2. Увеличьте build number в Xcode или через `pubspec.yaml`
3. Соберите:

```bash
flutter build ipa
```

Результат: `build/ios/ipa/ltfest.ipa`

---

## 3. GitHub Actions CI/CD

### 3.1 Структура папок

```
.github/
  workflows/
    ci.yml          # Проверка кода
    build-android.yml
    build-ios.yml
```

### 3.2 CI — проверка кода (`ci.yml`)

Создайте `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Generate code
        run: dart run build_runner build --delete-conflicting-outputs

      - name: Analyze
        run: flutter analyze lib

      - name: Run tests
        run: flutter test
```

### 3.3 Build Android (`build-android.yml`)

Создайте `.github/workflows/build-android.yml`:

```yaml
name: Build Android

on:
  workflow_dispatch:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          cache: true

      - name: Decode keystore
        run: |
          echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/upload-keystore.jks

      - name: Create key.properties
        run: |
          echo "storePassword=${{ secrets.KEYSTORE_PASSWORD }}" > android/key.properties
          echo "keyPassword=${{ secrets.KEY_PASSWORD }}" >> android/key.properties
          echo "keyAlias=${{ secrets.KEY_ALIAS }}" >> android/key.properties
          echo "storeFile=app/upload-keystore.jks" >> android/key.properties

      - name: Install dependencies
        run: flutter pub get

      - name: Generate code
        run: dart run build_runner build --delete-conflicting-outputs

      - name: Build AAB
        run: flutter build appbundle --release

      - name: Upload AAB
        uses: actions/upload-artifact@v4
        with:
          name: app-release
          path: build/app/outputs/bundle/release/app-release.aab
```

### 3.4 Добавление секретов в GitHub

1. Репозиторий → **Settings** → **Secrets and variables** → **Actions**
2. Добавьте:
   - `KEYSTORE_BASE64` — результат `base64 -w 0 upload-keystore.jks` (Linux/macOS)
   - `KEYSTORE_PASSWORD`
   - `KEY_ALIAS`
   - `KEY_PASSWORD`

### 3.5 Создание keystore (если ещё нет)

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Сохраните keystore и пароли в надёжном месте.

---

## 4. Deploy в Google Play

### 4.1 Регистрация в Google Play Console

1. [Google Play Console](https://play.google.com/console)
2. Создайте приложение
3. Заполните Store Listing, Content Rating, Privacy Policy

### 4.2 Загрузка AAB

**Вручную:**
1. **Production** → **Create new release**
2. Загрузите `app-release.aab`
3. Добавьте Release notes
4. **Review and rollout**

**Через GitHub Actions (опционально):**

Добавьте шаг в `build-android.yml`:

```yaml
      - name: Deploy to Play Store (Internal)
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.PLAY_STORE_JSON }}
          packageName: com.ltfest.mobile
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: internal
```

`PLAY_STORE_JSON` — JSON ключ сервисного аккаунта с доступом к Play Console.

### 4.3 Версионирование

- `versionCode` (build number) должен расти с каждой загрузкой
- Обновляйте в `pubspec.yaml`: `version: 0.2.2+28` (28 > 27)

---

## 5. Deploy в App Store

### 5.1 Требования

- Apple Developer Program ($99/год)
- macOS для сборки (или GitHub-hosted macOS runner)
- Xcode, сертификаты, provisioning profiles

### 5.2 Ручная загрузка

1. Соберите IPA: `flutter build ipa`
2. Откройте **Transporter** (Mac App Store) или **Xcode** → **Window** → **Organizer**
3. Загрузите `ltfest.ipa` в App Store Connect

### 5.3 Через fastlane (рекомендуется)

1. Установите fastlane: `gem install fastlane`
2. В папке `ios/`: `fastlane init`
3. Настройте `ios/fastlane/Fastfile`:

```ruby
default_platform(:ios)

platform :ios do
  desc "Build and upload to TestFlight"
  lane :beta do
    increment_build_number
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_testflight
  end
end
```

4. Запуск: `fastlane ios beta`

### 5.4 GitHub Actions для iOS

Требуется macOS runner. Пример:

```yaml
name: Build iOS

on:
  workflow_dispatch:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Generate code
        run: dart run build_runner build --delete-conflicting-outputs

      - name: Build IPA
        run: flutter build ipa --release

      - name: Upload IPA
        uses: actions/upload-artifact@v4
        with:
          name: ltfest-ipa
          path: build/ios/ipa/ltfest.ipa
```

---

## 6. Huawei AppGallery

Проект использует `com.huawei.agconnect`. Для публикации в AppGallery:

1. [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)
2. Создайте приложение
3. Настройте `agconnect-services.json` в `android/app/`
4. Соберите AAB: `flutter build appbundle --release`
5. Загрузите через веб-интерфейс AppGallery Connect

---

## 7. Чеклист перед релизом

- [ ] Обновлена версия в `pubspec.yaml`
- [ ] Выполнены `flutter pub get` и `build_runner`
- [ ] `flutter analyze lib` без ошибок
- [ ] Пройдены тесты `flutter test`
- [ ] Обновлены Release notes
- [ ] Проверены Firebase, Sentry, API endpoints (production)
- [ ] `google-services.json` и `GoogleService-Info.plist` актуальны
- [ ] Keystore и пароли сохранены в секретах CI
- [ ] Проверена работа push-уведомлений (FCM, APNs)

---

## Полезные команды

```bash
# Версия и build number
flutter --version

# Очистка
flutter clean && flutter pub get

# Сборка с Sentry
flutter build appbundle --release --dart-define=SENTRY_DSN=...

# Просмотр логов сборки
flutter build appbundle --verbose
```

---

## Контакты и ссылки

- **Sentry**: org `ltfest`, project `flutter`
- **Package**: `com.ltfest.mobile`
- **API**: см. `lib/data/services/api_endpoints.dart`
