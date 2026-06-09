import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';

import '../../../config/router/app_router.gr.dart';
import '../../../utils/design/app_colors.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeRoute(),
        const HistoryRoute(),
        const LeaderboardRoute(),
        const ProfileRoute(),
      ],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, -1),
        child: Container(
          height: AppMediaQuery.height(context) * .06,
          width: AppMediaQuery.width(context)*.14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(.35),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: FloatingActionButton(
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
              0,
            ),
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              context.router.push(const ScanFoodRoute());
            },
            child: Image.asset(AppImages.capture, color: Colors.white, height: AppMediaQuery.height(context)*.06, width: AppMediaQuery.width(context)*.06),
          ),
        ),
      ),

      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color(0xFF0F172A),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: AppMediaQuery.width(context) * .03, right: AppMediaQuery.width(context) * .03, bottom: AppMediaQuery.height(context) * .02),
            child: SizedBox(
              height: AppMediaQuery.height(context)*.095,
              child: CustomPaint(
                painter: BottomNavPainter(),
                child: Row(
                  children: [
                    Expanded(
                      child: _NavItem(
                        icon: AppImages.home,
                        isSelected: tabsRouter.activeIndex == 0,
                        onTap: () {
                          tabsRouter.setActiveIndex(0);
                        },
                      ),
                    ),
          
                    Expanded(
                      child: _NavItem(
                        icon: AppImages.history,
                        isSelected: tabsRouter.activeIndex == 1,
                        onTap: () {
                          tabsRouter.setActiveIndex(1);
                        },
                      ),
                    ),
          
                    AppGaps.w16(context),
          
                    Expanded(
                      child: _NavItem(
                        icon: AppImages.leaderboard,
                        isSelected: tabsRouter.activeIndex == 2,
                        onTap: () {
                          tabsRouter.setActiveIndex(2);
                        },
                      ),
                    ),
          
                    Expanded(
                      child: _NavItem(
                        icon: AppImages.user,
                        isSelected: tabsRouter.activeIndex == 3,
                        onTap: () {
                          tabsRouter.setActiveIndex(3);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            icon,
            height: AppMediaQuery.height(context) * .04,
            width: AppMediaQuery.width(context) * .06,
            color: isSelected
                ? AppColors.card
                : AppColors.white,
          ),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 250,
            ),
            curve: Curves.easeInOut,
            height: AppMediaQuery.height(context)*.005,
            width: isSelected ? 6 : 0,
            decoration: const BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;

    final path = Path();

    const radius = 40.0;
    const notchDepth = 36.0;

    path.moveTo(radius, 0);

    /// Left side
    path.lineTo(size.width * .30, 0);

    /// Deep left curve
    path.cubicTo(
      size.width * .40,
      0,
      size.width * .40,
      notchDepth,
      size.width * .50,
      notchDepth,
    );

    /// Deep right curve
    path.cubicTo(
      size.width * .60,
      notchDepth,
      size.width * .60,
      0,
      size.width * .70,
      0,
    );

    /// Top right
    path.lineTo(size.width - radius, 0);

    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      radius,
    );

    /// Right side
    path.lineTo(
      size.width,
      size.height - radius,
    );

    /// Bottom right corner
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    /// Bottom
    path.lineTo(radius, size.height);

    /// Bottom left corner
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - radius,
    );

    /// Left side
    path.lineTo(0, radius);

    /// Top left corner
    path.quadraticBezierTo(
      0,
      0,
      radius,
      0,
    );

    path.close();

    canvas.drawShadow(
      path,
      Colors.black.withOpacity(.25),
      20,
      true,
    );

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
