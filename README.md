# ltfest

A new Flutter project.

## Push-уведомления (iOS / Android / Huawei)

Клиентская интеграция добавлена в [push_notifications.dart](file:///c:/Users/vlad/Desktop/ltfest-mobile/lib/notifications/push/push_notifications.dart) и инициализируется из [main.dart](file:///c:/Users/vlad/Desktop/ltfest-mobile/lib/main.dart).

### Android (FCM)
- Добавить `android/app/google-services.json` из Firebase Console.
- Убедиться, что `applicationId` совпадает с package name в Firebase.

### iOS (FCM/APNs)
- Добавить `ios/Runner/GoogleService-Info.plist` из Firebase Console.
- В Xcode включить Capabilities: Push Notifications и Background Modes → Remote notifications.
- В Apple Developer Portal создать APNs key/cert и подключить его в Firebase (APNs Authentication Key).

### Huawei (HMS Push Kit)
- В AppGallery Connect включить Push Kit и скачать `agconnect-services.json`.
- Положить файл в `android/app/agconnect-services.json`.
- Добавить SHA-256 подпись приложения в AppGallery Connect (debug/release в зависимости от сборки).

### Общие заметки
- На Android 13+ запрашивается разрешение на уведомления (`POST_NOTIFICATIONS`).
- Для маршрутизации по нажатию на уведомление можно слушать `PushNotifications.messages` и выполнять навигацию на основе payload.
