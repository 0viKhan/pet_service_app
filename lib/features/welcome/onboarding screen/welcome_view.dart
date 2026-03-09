import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_helper.dart';
import '../controller/welcome_controller.dart';
import '../widgets/widgets.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final item = controller.currentPage;
        final isTablet = ResponsiveHelper.isTablet(context);

        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.96,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: SizedBox(
                key: ValueKey(item.image),
                width: double.infinity,
                height: MediaQuery.of(context).size.height *
                    (isTablet ? 0.7 : 0.75),
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = isTablet
                      ? (constraints.maxWidth * 0.88).clamp(0, 760).toDouble()
                      : constraints.maxWidth;

                  return SizedBox(
                    width: cardWidth,
                    child: WelcomeBottomCard(
                      item: item,
                      isTablet: isTablet,
                      currentIndex: controller.currentIndex.value,
                      totalPages: controller.welcomePages.length,
                      onNext: controller.nextPage,
                      isLastPage: controller.isLastPage,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}