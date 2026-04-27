import 'package:auto_route/annotations.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/presentation/home/page/home_page.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_images.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  static final List<Widget> _pages = const [
    HomePage(),
    HomePage(),
    SizedBox.shrink(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, index, _) {
        return Scaffold(
          body: _pages[index],
          bottomNavigationBar: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppMediaQuery.width(context)*.04,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: BottomNavigationBar(
                      currentIndex: index,
                      onTap: (newIndex) => _selectedIndex.value = newIndex,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      selectedItemColor: AppColors.primaryColor,
                      unselectedItemColor: Colors.grey,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      elevation: 0,
                      items: [
                        BottomNavigationBarItem(
                          icon: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppImages.home, height: 26,
                                  color: index == 0 ? AppColors.black : AppColors.gray),
                              if (index == 0)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 20,
                                  color: AppColors.primaryColor,
                                ),
                            ],
                          ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppImages.home, height: 26,
                                  color: index == 1 ? AppColors.black : AppColors.gray),
                              if (index == 1)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 20,
                                  color: AppColors.primaryColor,
                                ),
                            ],
                          ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: const SizedBox.shrink(),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppImages.barChart, height: 26,
                                  color: index == 3 ? AppColors.black : AppColors.gray),
                              if (index == 3)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 20,
                                  color: AppColors.primaryColor,
                                ),
                            ],
                          ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppImages.user, height: 26,
                                  color: index == 4 ? AppColors.black : AppColors.gray),
                              if (index == 4)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 20,
                                  color: AppColors.primaryColor,
                                ),
                            ],
                          ),
                          label: "",
                        ),
                      ],
                    )
                  )
                )
              ),

              // Floating camera button
              Positioned(
                bottom: AppMediaQuery.height(context) * .06,
                left: MediaQuery.of(context).size.width / 2 - 35, // adjust for new size
                child: SizedBox(
                  width: AppMediaQuery.width(context)*.15,
                  height: AppMediaQuery.height(context)*.065,
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {},
                    backgroundColor: AppColors.primaryColor,
                    shape: const CircleBorder(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Image.asset(AppImages.capture, height: 30, color : AppColors.black)
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
