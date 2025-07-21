import 'package:Payment/Modules/Payment/widgets/success_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Models/payment_intent_input_model.dart';
import '../../Utilities/strings.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Utilities/theme_helper.dart';
import '../../Widgets/app_colors.dart';
import '../../Widgets/app_fonts.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_text.dart';
import '../../generated/assets.dart';
import 'payment_controller.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = "cart";
  const PaymentScreen({super.key});

  @override
  createState() => _PaymentScreenState();
}

class _PaymentScreenState extends StateMVC<PaymentScreen> {
  late PaymentController con;
  _PaymentScreenState() : super(PaymentController()) {
    con = controller as PaymentController;
  }

  int quantity = 1;
  int price = 0;
  late final ratingController;
  late double rating;

  double userRating = 3.0;
  int ratingBarMode = 1;
  double initialRating = 2.0;
  bool isRTLMode = false;
  bool isVertical = false;
  int selectedMethod = 0;
  IconData? selectedIcon;
  void selectPaymentMethod(int method) {
    if (selectedMethod == method) {
      selectedMethod = 0; // Deselect if already selected
    } else {
      selectedMethod = method; // Select the chosen method
    }
    setState(() {}); // Trigger the UI to update
  }

  @override
  void initState() {
    super.initState();
    ratingController = TextEditingController(text: '3.0');
    rating = initialRating;
  }

  @override
  Widget build(BuildContext context) {
    int price = 0;
    int calculateStripeAmount(int quantity, double pricePerUnit) {
      return (quantity * pricePerUnit *  100.0)
          .toInt(); // ضرب × 100 = تحويل للجنيه إلى قرش
    }
    String formatPrice(double amount) {
      final formatter = NumberFormat("#,##0.00", "fr_FR"); // تستخدم الفاصلة بدلاً من النقطة
      return formatter.format(amount);
    }
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
      backgroundColor:Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              Assets.imagesPizza,
              //  "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",

              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          expandedHeight: 220,
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration:  BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.r),
                    topRight: Radius.circular(
                      50,
                    ))),
            padding: const EdgeInsets.only(left: 20.0, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                CustomText(text: "Pizza Mix Cheese"),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.kPrimaryColor,
                    ),
                    CustomText(
                      text: '4 Star Ratings',
                      color: AppColors.kPrimaryColor,
                      size: AppFontSize.s14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        CustomText(
                          text: 'Rs.\$75',
                          fontWeight: FontWeight.bold,
                          size: 25,
                        ),
                        const CustomText(
                          text: '/per Portion',
                          fontWeight: FontWeight.normal,
                          size: 12,
                        ),
                      ],
                    )
                  ],
                ),
                CustomText(
                  text: 'Description',
                  color: AppColors.blackColor,
                  size: AppFontSize.s16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                Container(
                  //  width: 316,
                  //height: 200,
                  child: Text(
                    'Lorem ipsum dolor sit amet,  consectetur adipiscing elit. Ornare leo non mollis id cursus. Eu euismod faucibus in leo malesuada',
                    style: TextStyle(
                        //  overflow: TextOverflow.ellipsis,
                        height: 1.2,
                        fontSize: 14,
                        color: AppColors.lightGrey),
                  ),
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: 'Customize your Order',
                  color: AppColors.blackColor,
                  size: AppFontSize.s16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 333.h,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.lightGrey.withOpacity(.2),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        CustomText(
                            text: '- Select the size of portion -',
                            size: AppFontSize.s14),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_drop_down),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 333.h,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        CustomText(
                            text: '- Select the ingredients -',
                            size: AppFontSize.s14),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_drop_down),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 333.h,
                  height: 45,
                  child: Row(children: [
                    const CustomText(
                        text: 'Number of Portion', size: AppFontSize.s14),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity--;
                          print(quantity);
                        });
                        if (quantity < 1) {
                          quantity = 1;
                          print('rrrrrrrrrrrrrrr');
                        }

                        //print(price);
                      },
                      child: Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(blurRadius: 1, color: AppColors.lightGrey)
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        //  color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "$quantity",
                          style: TextStyle(
                              color: AppColors.kPrimaryColor, fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                          print(quantity);
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1, color: AppColors.lightGrey)
                            ]),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                buildStack(price, calculateStripeAmount, context),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Stack buildStack(
      int price,
      int Function(int numberOfPieces, double pricePerPiece) calculateStripeAmount,
      BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 90.w,
            height: 150.h,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Center(
            child: Container(
              height: 147.h,
              width: 260.w,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 13.0, bottom: 13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CustomText(
                      text: 'Total Price',
                      fontWeight: FontWeight.w400,
                      size: 14,
                    ),
                    TextButton(
                      onPressed: () {
                        // setState(() {
                        price = calculateStripeAmount((quantity), 75/100.0);
                        // });
                      },
                      child: Text(
                        'LKR \$${calculateStripeAmount((quantity), 75/100.0)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    // CustomText(text: '$price',
                    //   fontWeight: FontWeight.bold,
                    //   size: 18,),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 18),
                      child: Container(
                        //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        // padding: const EdgeInsets.only(right: 200.0),
                        width: 175,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // GoRouter.of(context).pushNamed(PaymentScreen.routeName);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) =>
                                              Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                child: Container(
                                                  width: 400.w,
                                                  // height: 300.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ThemeClass.of(context)
                                                            .background,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 15.h),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              icon: selectedMethod ==
                                                                      1
                                                                  ? SvgPicture
                                                                      .asset(Assets
                                                                          .imagesFilledRadioIcon)
                                                                  : SvgPicture
                                                                      .asset(Assets
                                                                          .imagesLightRadioIcon),
                                                              onPressed: () {
                                                                setState(() {
                                                                  selectPaymentMethod(
                                                                      1);
                                                                });
                                                              },
                                                            ),
                                                            Gap(5.w),
                                                            SizedBox(
                                                              width: 56.w,
                                                              height: 36.h,
                                                              child:
                                                                  Image.asset(
                                                                Assets
                                                                    .imagesVisaLogo,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                                icon: selectedMethod ==
                                                                        2
                                                                    ? SvgPicture
                                                                        .asset(Assets
                                                                            .imagesFilledRadioIcon)
                                                                    : SvgPicture
                                                                        .asset(Assets
                                                                            .imagesLightRadioIcon),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    selectPaymentMethod(
                                                                        2);
                                                                  });
                                                                }),
                                                            Image.asset(
                                                              Assets
                                                                  .imagesPayPali,
                                                              width: 50.w,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              icon: selectedMethod ==
                                                                      3
                                                                  ? SvgPicture
                                                                      .asset(Assets
                                                                          .imagesFilledRadioIcon)
                                                                  : SvgPicture
                                                                      .asset(Assets
                                                                          .imagesLightRadioIcon),
                                                              onPressed: () {
                                                                setState(() {
                                                                  selectPaymentMethod(
                                                                      3);
                                                                });
                                                              },
                                                            ),
                                                            Gap(5.w),
                                                            Text(
                                                              "Cash",
                                                              style: TextStyleHelper
                                                                      .of(
                                                                          context)
                                                                  .h_24
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ],
                                                        ),
                                                        CustomButtonWidget
                                                            .primary(
                                                          onTap: () async {
                                                           // int quantity = 2;
                                                            double
                                                                pricePerUnit =
                                                                75.0;

                                                            int totalAmount =
                                                          calculateStripeAmount(
                                                              quantity,
                                                                    pricePerUnit);
                                                            // double amountInEGP = widget.stripeAmount / 100.0;
                                                            //
                                                            // String formatted = formatPrice(amountInEGP);// Stripe amount

                                                            final inputModel =
                                                                PaymentIntentInputModel(
                                                                    amount: totalAmount
                                                                        .toString(), // Stripe expects string
                                                                    currency:
                                                                        "egp",
                                                                    customerId:
                                                                        'cus_ShPPxjuZGB5viQ');
                                                            if (selectedMethod ==
                                                                1) {
                                                              await con.makePayment(
                                                                  context: context,
                                                                  paymentIntentInputModel:
                                                                      inputModel);

                                                            } else {
                                                              if (selectedMethod ==
                                                                  2)
                                                              setState(() {});
                                                              con.testPayPallPayment(
                                                                  context);
                                                              //context.pop();
                                                            }
                                                          },
                                                          height: 45.h,
                                                          title: "Pay Now",
                                                          //(7#vW84I
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.shopping_cart,
                                  size: 22,
                                  color: AppColors.whiteColor,
                                )),
                            const Text(
                              'Add To Cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
