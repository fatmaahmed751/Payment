import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../Widgets/app_colors.dart';
import '../../Widgets/app_fonts.dart';
import '../../Widgets/custom_text.dart';
import '../../generated/assets.dart';


class MyCartScreen extends StatefulWidget{
  static const routeName = "cart";
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  int quantity=1;
  int price = 0;
  late final ratingController;
  late double rating;

  double userRating = 3.0;
  int ratingBarMode = 1;
  double initialRating = 2.0;
  bool isRTLMode = false;
  bool isVertical = false;

  IconData? selectedIcon;

  @override
  void initState() {
    super.initState();
    ratingController = TextEditingController(text: '3.0');
    rating = initialRating;
  }

  @override
  Widget build(BuildContext context) {
    int price = 0;
    int calculatePrice(int numberOfPieces, double pricePerPiece) {
      return (numberOfPieces * pricePerPiece).toInt();
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverAppBar(

                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                   Assets.imagesFood,
                    //"https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",

                    width: double.maxFinite,
                    fit: BoxFit.cover,),
                ),

                expandedHeight: 280,
              ),

              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50
                          ))
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          text:"widget.recipeName"
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // RatingBar.builder(
                      //   initialRating: initialRating,
                      //   minRating: 1,
                      //   direction: isVertical ? Axis.vertical : Axis.horizontal,
                      //   allowHalfRating: true,
                      //   unratedColor: AppColors.kPrimaryColor.withOpacity(0.2),
                      //   itemCount: 5,
                      //   itemSize: 20.0,
                      //   itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      //   itemBuilder: (context,index ) => Icon(
                      //     selectedIcon ?? Icons.star,
                      //     color: AppColors.kPrimaryColor,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     setState(() {
                      //       rating = rating;
                      //     });
                      //   },
                      //   updateOnDrag: true,
                      // ),
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
                        width: 316,
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

                        child:  Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: Row(
                            children: [
                              SizedBox(width: 7,),
                              CustomText(
                                  text: '- Select the size of portion -',
                                  size: AppFontSize.s14),
                              Spacer(),
                              IconButton(
                                icon:Icon(Icons.arrow_drop_down),
                                onPressed: (){},
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
                          borderRadius: BorderRadius.circular(5.0

                          ),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.only(left: 3.0),
                          child: Row(
                            children: [
                              SizedBox(width: 7,),
                              CustomText(
                                  text: '- Select the ingredients -',
                                  size: AppFontSize.s14),
                              Spacer(),
                              IconButton(
                                icon:Icon(Icons.arrow_drop_down),
                                onPressed: (){},
                              ),

                            ],
                          ),

                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 333.h,
                        height: 45,

                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Row(
                              children: [
                                const CustomText(text: 'Number of Portion',
                                    size: AppFontSize.s14),
                                const Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      quantity--;
                                      print(quantity);

                                      // widget.prices-=widget.prices;
                                      //price = widget.prices;

                                    });
                                    if(quantity<1){
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
                                        BoxShadow(
                                            blurRadius: 1,
                                            color: AppColors.lightGrey
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text('-',
                                        style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: 18),),
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
                                      color: AppColors.kPrimaryColor,),

                                  ),
                                  child: Center(
                                    child: Text("$quantity",
                                      style: TextStyle(
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 15),),
                                  ),
                                ),
                                const SizedBox(width: 2),

                                GestureDetector(
                                  onTap: (){


                                    setState(() {
                                      quantity++;
                                      print(quantity);
                                    });

                                    // widget.prices*=2;
                                    //  price = widget.prices;
                                    //print(price);

                                    //quantity = quantity+1;


                                  },
                                  child: Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              color: AppColors.lightGrey
                                          )
                                        ]
                                    ),
                                    child: Center(
                                      child: Text('+',
                                        style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: 15),),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                      Stack(
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
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: Container(
                                height: 122.h,
                                width: 260.w,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(10)),
                                    color: Colors.white

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13.0, bottom: 13),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      const CustomText(text: 'Total Price',
                                        fontWeight: FontWeight.w400,
                                        size: 14,),
                                      TextButton(
                                        onPressed:(){
                                          // setState(() {
                                          price = calculatePrice((quantity),75);
                                          // });
                                        },
                                        child:Text('LKR \$${calculatePrice((quantity), 75)}',
                                          style:TextStyle(
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
                                        padding: const EdgeInsets.only(
                                            right: 20.0, left: 18),
                                        child: Container(
                                          //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                          // padding: const EdgeInsets.only(right: 200.0),
                                          width: 175,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimaryColor,
                                            borderRadius: BorderRadius
                                                .circular(100.0),
                                          ),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    // print('iiiiiiiiiiiiiiiiiiii');
                                                    //
                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(builder: (context) =>  MyOrderScreen(
                                                    //       image: widget.image,
                                                    //       rate:
                                                    //       widget.rate,
                                                    //       recipeName:
                                                    //       widget.recipeName,
                                                    //       prices:
                                                    //       widget.prices,
                                                    //       categoryName:
                                                    //       widget.categoryName ,
                                                    //       type:
                                                    //       widget.type ,
                                                    //       price:
                                                    //       //price.toDouble()
                                                    //       calculatePrice((quantity), widget.prices).toDouble(),
                                                    //     )
                                                    //     )
                                                   // );
                                                  },
                                                  icon: Icon(
                                                    Icons.shopping_cart,
                                                    size: 22,
                                                    color: AppColors
                                                        .whiteColor,
                                                  )),
                                              const Text(
                                                'Add To Cart',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w400),
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

                      ),

                    ],
                  ),
                ),
              ),
            ]
        ),
      ),

    );
  }

}