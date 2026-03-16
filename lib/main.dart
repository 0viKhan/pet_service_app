import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'core/services/photo_picker_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe
  Stripe.publishableKey = 'pk_test_51TBUbB5DDGO0lwPBsIBombJymCiMPeXieuXDBGOIH3lkSb67sdVHx2gjEvonWlElPbCCh3HkTa7n6XKcGeYKRLTw000FQOQ3Zl';
  Stripe.merchantIdentifier = 'sk_test_51TBUbB5DDGO0lwPBHBwBxCURuhddoDQty2yLOBtpkhFY9u0eaT5QtY9S0QaYXIgyJRrbwnOp9wgEIoekTYhm9V3T00SnWvDkhk'; // optional for Apple Pay
  await Stripe.instance.applySettings(); // apply settings

  Get.put(PhotoPickerService());

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: (context, child) {
            child = DevicePreview.appBuilder(context, child);
            child = EasyLoading.init()(context, child);
            return child;
          },
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
        );
      },
    );
  }
}