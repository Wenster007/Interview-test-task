import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test2/constants/app_colors.dart';
import 'package:test2/constants/font_sizes.dart';
import 'package:test2/constants/size_config.dart';
import 'package:test2/screens/navigation_screen.dart';
import 'package:test2/widgets/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to ProductsScreen after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(
        () => const NavigationScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/splash.jpg', fit: BoxFit.fill),
          ),

          // Black Shadow Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.2),
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Text Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.scaleHeight(70)),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: AppText(
                  text: 'My Store',
                  fontFamily: FontTypes.playFairDisplay,
                  fontSize: SizeConfig.scaleHeight(50),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(425)),

              AppText(
                text: "Valkommem",
                fontSize: FontSizes.pixel14,
                fontWeight: FontWeight.w800,
                fontColor: AppColors.white,
              ),
              SizedBox(height: SizeConfig.scaleHeight(10)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // Added padding for readability
                child: AppText(
                  text:
                      "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.",
                  fontSize: FontSizes.pixel12,
                  fontColor: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
