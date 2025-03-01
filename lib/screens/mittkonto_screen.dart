import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test2/constants/app_colors.dart';
import 'package:test2/constants/font_sizes.dart';
import 'package:test2/constants/size_config.dart';
import 'package:test2/widgets/app_text.dart';

class MittkontoScreen extends StatelessWidget {
  const MittkontoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(21)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.scaleHeight(31),
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: "Mitt Konto",
                  fontFamily: FontTypes.playFairDisplay,
                  fontSize: FontSizes.pixel24,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.scaleHeight(34)),
            Container(
              height: SizeConfig.scaleHeight(100),
              width: double.infinity,

              padding: EdgeInsets.all(SizeConfig.scaleHeight(12)),
              margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(12)),
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: SizeConfig.scaleHeight(32),
                    backgroundColor: AppColors.white,
                  ),
                  SizedBox(width: SizeConfig.scaleHeight(16)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.scaleHeight(150),
                        child: AppText(
                          text: "Ahmed Khan Khisro",
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizes.pixel14,
                          overflow: TextOverflow.ellipsis,
                          alignment: TextAlign.start,
                          fontColor: AppColors.white,
                        ),
                      ),
                      AppText(
                        text: "ahmadkhankhisro@gmail.com",
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizes.pixel10,
                        overflow: TextOverflow.ellipsis,
                        fontColor: AppColors.white,
                      ),
                      AppText(
                        text: "03149958999",
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizes.pixel10,
                        overflow: TextOverflow.ellipsis,
                        fontColor: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(63)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.scaleHeight(23),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/setting.svg',
                        height: SizeConfig.scaleHeight(18),
                      ),
                      SizedBox(width: SizeConfig.scaleHeight(13)),
                      AppText(
                        text: "Kontoninstallningar",
                        fontSize: FontSizes.pixel14,
                        overflow: TextOverflow.ellipsis,
                        alignment: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(26)),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/mina.svg',
                        height: SizeConfig.scaleHeight(18),
                      ),
                      SizedBox(width: SizeConfig.scaleHeight(13)),
                      AppText(
                        text: "Mina Betalmedator",
                        fontSize: FontSizes.pixel14,
                        overflow: TextOverflow.ellipsis,
                        alignment: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(26)),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/support.svg',
                        height: SizeConfig.scaleHeight(18),
                      ),
                      SizedBox(width: SizeConfig.scaleHeight(13)),
                      AppText(
                        text: "Support",
                        fontSize: FontSizes.pixel14,
                        overflow: TextOverflow.ellipsis,
                        alignment: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(26)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
