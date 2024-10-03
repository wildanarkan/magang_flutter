import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextbasis_hris/common/app_color.dart';
import 'package:nextbasis_hris/common/app_pages.dart';
import 'package:nextbasis_hris/common/app_routes.dart';
import 'package:nextbasis_hris/controllers/login_controller.dart';
import 'package:nextbasis_hris/data/repo/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp();

  // Inisialisasi GetStorage
  await GetStorage.init();

  // Inisialisasi Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Permintaan izin notifikasi (untuk iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Mendapatkan token FCM
  String? token = await messaging.getToken();
  print("FCM Token: $token");
  // Kirim token ini ke server untuk disimpan jika perlu

  // Listener untuk notifikasi ketika aplikasi sedang dibuka (foreground)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message while in the foreground!');

    if (message.notification != null) {
      String? title = message.notification?.title;
      String? body = message.notification?.body;
      print('Message contained a notification: $title - $body');

      Get.snackbar(
        title ?? 'Notification',
        body ?? 'You have a new message.',
        backgroundColor: AppColor.success,
      );
    }
  });

  // Listener untuk notifikasi ketika aplikasi dibuka melalui notifikasi
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    // Handle aksi ketika notifikasi di-tap
  });

  // Menambahkan dependency ke GetX
  Get.put(UserRepository());
  Get.put<LoginController>(LoginController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final isLoggedIn = storage.read('isLoggedIn') ?? false;

    return GetMaterialApp(
      theme: ThemeData(
        dividerTheme: DividerThemeData(color: AppColor.line),
        scaffoldBackgroundColor: AppColor.scaffold,
      ),
      initialRoute: isLoggedIn ? AppRoutes.navigator : AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
