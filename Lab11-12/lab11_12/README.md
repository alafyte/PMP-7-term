# Как запустить 

1. Создать проект на https://console.firebase.google.com/u/0/
2. Добавить android-приложение. Package name = com.example.lab11_12
3. Следовать гайду (Step 1, 2, 3):
https://firebase.google.com/docs/flutter/setup?platform=android

flutterfire CLI возможно придется добавить в переменные среды:
```
C:\Users\%USERNAME%\AppData\Local\Pub\Cache\bin
```
4. Команда configure должна создать firebase.json файл в корне проекта и firebase_options.dart в папке lib.
5. В firebase console в разделе Build создать Firestore Database.
6. В firebase console в разделе Build включить Authenticaton. В разделе sign-in method настроить два метода:
  - Email/Password
  - Google (тут только support email указать, остальное не трогать)
7. Для аутентификации через гугл нужно:
  - В терминале перейти в android папку
  - Запустить ./gradlew signingReport (нужно поменять org.gradle.java.home в gradle.properties)
  - Скопировать из вывода SHA1
  - В настройках приложения добавить скопированное в SHA certificate fingerprints
8. После настроек аутентификации, скачать файл google-services.json из настроек приложения и добавить его в android/app
9. Для демонстрации кнопки Forgot password предварительно нужно ввести email в поле формы.
10. Форма добавления товара открывается по нажатию на кнопку меню на главном экране.
11. Редактирование товара: по кнопке карандаша на странице товара. 
12. Удаление товара: кнопка корзины на странице изменения.
13. Картинки: ссылки на изображение с инета, например:
```
https://wallpapers.com/images/hd/bright-orange-nike-air-sneaker-b2vcaqawagiq0myo.png
```
14. Notifications: в firebase console в разделе Run выбрать Messaging. Нажать create your first campaign. Выбрать Firebase Notification message, ввести title и notification text. Нажать Send test message. Добавить FCM registration token (взять из вывода в консоль при запуске приложения). Нажать test

