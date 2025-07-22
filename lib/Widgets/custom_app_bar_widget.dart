import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../Utilities/shared_preferences.dart';
import '../Utilities/strings.dart';
import '../Utilities/theme_helper.dart';
import '../generated/assets.dart';

enum _AppBarType { main, mainDetails, details, secondary, secondaryGradient }

//
class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final _AppBarType _appBarType;
  final String screenName;
  final List<Widget>? actions;

  final String title;
  final String icon;
  // final TextEditingController? controller;
  final void Function()? onPressed;
//
  const CustomAppBarWidget.mainScreen(

      // final void Function()? onPressed,
      {
    Key? key,
    this.onPressed,
    required this.title,
    required this.icon,
    this.actions,
    // this.controller
  })  : _appBarType = _AppBarType.main,
        screenName = title,
        //actions = const [],
        super(key: key);
//
  const CustomAppBarWidget.detailsScreen({
    Key? key,
    required this.title,
    required this.icon,
    this.actions,
    this.onPressed,
    //  this.controller
  })  : _appBarType = _AppBarType.mainDetails,
        screenName = title,
        super(key: key);
//
  const CustomAppBarWidget.secondaryGradient({
    Key? key,
    required this.title,
    this.onPressed,
    required this.icon,
    //  this.controller
  })  : _appBarType = _AppBarType.secondaryGradient,
        screenName = title,
        actions = const [],
        super(key: key);

  const CustomAppBarWidget.gradientDetails({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
    //  this.controller
  })  : _appBarType = _AppBarType.details,
        screenName = title,
        actions = const [],
        super(key: key);

  const CustomAppBarWidget.secondaryAppBar({
    Key? key,
    required this.title,
    required this.icon,
    // this.controller,

    this.onPressed,
    this.actions,
  })  : _appBarType = _AppBarType.secondary,
        screenName = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (_appBarType) {
      case _AppBarType.main:
        return MainAppBarWidget(
            title: screenName, onPressed: onPressed, icon: icon, actions: []
            //  () {  },
            );
      case _AppBarType.secondaryGradient:
        return SecondaryGradientAppBarWidget(
          title: screenName,
          //  () {  },
        );
      case _AppBarType.mainDetails:
        return MainDetailsAppBarWidget(
          title: screenName,
          onPressed: onPressed,
          icon: icon,
          actions: actions,
        );
      case _AppBarType.details:
        return GradientAppBarWidget(
          title: screenName,
          onPressed: onPressed,
          icon: icon,
        );
      case _AppBarType.secondary:
        return SecondaryAppBarWidget(
          title: screenName,
          icon: icon,
          function: onPressed,
          controller: TextEditingController(),
        );
      }
  }

//
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 35.h);
// }
}

class MainAppBarWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String icon;
  final List<Widget>? actions;
  const MainAppBarWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final language = Provider.of<AppLanguage>(context, listen: false).fetchLocale(context);
    SharedPref.getCurrentLanguage();
    return SizedBox(
      height: 320.h,
      child: Stack(
        children: [
          Container(
            height: 290.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors
                    : ThemeClass.backgroundGradiant,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 16.w, top: 65.h, end: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //const SizedBox(width: 15,),
                  Gap(8.w),
                  Image.asset(
                  "",
                    width: 24.w,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                            color: ThemeClass.of(context).background,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w, vertical: 6.h),

                        )),
                  ),
                  Gap(8.w),
                  GestureDetector(
                    onTap: () {
                    // GoRouter.of(context).pushNamed(CartScreen.routeName);
                    },
                    child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                            color: ThemeClass.of(context).background,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w, vertical: 6.h),

                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainDetailsAppBarWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String? icon;
  final List<Widget>? actions;
  const MainDetailsAppBarWidget(
      {Key? key,
      required this.title,
      this.icon,
      required this.onPressed,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 30.h),
      child: Container(
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Transform.flip(
                    flipX:
                        SharedPref.getCurrentLanguage() == "ar" ? true : false,
                  ),
                onPressed: () {
                  context.pop();
                }),
            Gap(10.w),

          ],
        ),
      ),
    );
  }
}

class SecondaryAppBarWidget extends StatefulWidget {
  final String title;
  final String? icon;

  final TextEditingController controller;
  final void Function()? function;

  const SecondaryAppBarWidget({
    Key? key,
    required this.title,
    this.icon,
    required this.controller,
    this.function,
    // required this.controller
    //this.onDeleteIconToggle
  }) : super(key: key);

  @override
  createState() => SecondaryAppBarWidgetState();
}

class SecondaryAppBarWidgetState extends State<SecondaryAppBarWidget> {
  // bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    print('SecondaryAppBarWidget rebuild with icon: ${widget.icon}');
    return SizedBox(
      child: Stack(
        children: [
          Container(
            // height:500.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:

                   ThemeClass.backgroundGradiant,
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 24.w, top: 60.h, end: 24.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //const SizedBox(width: 15,),


                      Gap(8.w),
                      Image.asset(
                "",
                        width: 24.w,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                color: ThemeClass.of(context).background,
                                borderRadius: BorderRadius.circular(30.r)),
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6.w, vertical: 6.h),

                            )),
                      ),
                      Gap(8.w),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                color: ThemeClass.of(context).background,
                                borderRadius: BorderRadius.circular(30.r)),
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6.w, vertical: 6.h),

                            )),
                      ),
                    ],
                  ),
                  Gap(30.h),

                  // SearchWidget(
                  //     width: 382.w,
                  //     backGroundColor: ThemeClass.of(context).background,
                  //     onSearch: (String? text) {},
                  //     isSearch: true,
                  //     controller: widget.controller,
                  //     onRemove: () {},
                  //     onChange: (String? value) {
                  //
                  //     }),
                  //
                  // CustomTextFieldWidget(
                  //   height: 45.h,
                  //   insidePadding: EdgeInsets.symmetric(vertical: 10.h),
                  //   borderRadiusValue: 30.r,
                  //   isDense: true,
                  //   prefixIcon: SvgPicture.asset(Assets.imagesSearch),
                  //   hint: Strings.searchHere.tr,
                  //   backGroundColor: ThemeClass.of(context).background,
                  // controller:widget.controller,
                  //   hintStyle: TextStyleHelper.of(context)
                  //       .b_16
                  //       .copyWith(color: ThemeClass.of(context).labelColor),
                  //   validator: (v) => Validate.validateEmail(v),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondaryGradientAppBarWidget extends StatelessWidget {
  final String title;
  const SecondaryGradientAppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 50.h),
      child: Container(
        // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(5.w),
            // InkWell(
            //   onTap: () {
            //    context.pop();
            //   },
            //   child: CircleAvatar(
            //     radius: 18.r,
            //    // backgroundColor:
            //    // ThemeClass.of(context).blueColor,
            //     child:  Transform.flip(
            //       flipX: SharedPref.getCurrentLanguage() == "ar" ? true : false,
            //       child: SvgPicture.asset(
            //         Assets.imagesDarkArrowBack,
            //       ),
            //     ),
            //   ),
            // ),
            Spacer(),

            Spacer()
          ],
        ),
      ),
    );
  }
}

class GradientAppBarWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String? icon;

  const GradientAppBarWidget({
    Key? key,
    required this.title,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 50.h),
      child: Container(
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Gap(50.w),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
