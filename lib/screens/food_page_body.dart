import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tell_am/components/big_text.dart';
import 'package:tell_am/utils/colors.dart';
import 'package:tell_am/utils/diementions.dart';
import 'package:tell_am/widget/icon_and_text_widget.dart';
import 'package:tell_am/widget/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
    viewportFraction: 0.85, // Adjusts the size of the pages
    initialPage: 0, // Initial page to display
  );

  var _currentPageValue = 0.0; // Current page value for PageView
  double _scaleFactor = 0.8; // Scale factor for the pages
  double _height = Diementions.pageViewContainer; // Height of the page view container

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  } 

  @override
  void dispose() {
    pageController.dispose(); // Dispose of the PageController when not needed
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final decorator = DotsDecorator(
      activeColor: AppColors.mainColor,
      size: const Size.square(9.0),
      activeSize: const Size(18.0, 9.0),
      spacing: const EdgeInsets.symmetric(horizontal: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );

    return Column(
      children: [

        // Slider section
        SizedBox(height: Diementions.height10),
        Container(
          height: Diementions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5, // Number of items in the PageView
            itemBuilder: (context, position){
              return _buildPageItem(position);
            },),
        ),
        SizedBox(height: 6),

        // Dots indicator section
        Container(
          child: DotsIndicator(
            dotsCount: 5, // Number of dots
            position: _currentPageValue, // Current page value
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
            ),
             // Custom decorator for the dots
          ),
        ),
        ),
      
        SizedBox(height: Diementions.height30),
        // Popular text section
        Container(
          margin: EdgeInsets.only(left: Diementions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular Restaurant", size: Diementions.font26, color: AppColors.mainBlackColor),
              SizedBox(width: Diementions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: SmallText(text: ".", color: AppColors.mainColor, size: Diementions.font26),
              ),    
            ],
          ),
        ),
        SizedBox(height: Diementions.height10),
        // Popular food items section
        Container(
          height: 700,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: Diementions.width10),
                child: Row(
                  children: [
                    //Image section
                    Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.only(bottom: Diementions.height10, left: Diementions.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainWhiteColor,
                        borderRadius: BorderRadius.circular(Diementions.radius20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/food/food2.jpg'), // Example image
                        ),
                      ),
                    ),
                    // Text section
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.mainWhiteColor,
                          borderRadius: BorderRadius.only(
                            topRight:Radius.circular(Diementions.radius20),
                            bottomRight: Radius.circular(Diementions.radius20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left:Diementions.width5, right: Diementions.width5, top: Diementions.height10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start ,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(
                                text: "Beans and Plantain Potage",
                              ),
                              SizedBox(height: Diementions.height10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.food_bank_rounded,
                                    color: AppColors.textColor,
                                  ),
                                  SizedBox(width: Diementions.width5),
                                  BigText(
                                    text: "Big Belle Restaurant",
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: Diementions.height15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(
                                    icon: Icons.circle_sharp,
                                    text: "Normal",
                                    iconColor: AppColors.iconColor1,
                                    color: AppColors.textColor,
                                    size: 18.0,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text: "1.7km",
                                    iconColor: AppColors.mainColor,
                                    color: AppColors.textColor,
                                    size: 18.0,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.access_time_rounded,
                                    text: "32min",
                                    iconColor: AppColors.iconColor2,
                                    color: AppColors.textColor,
                                    size: 18.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans =_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)..setTranslationRaw(0, currTrans, 0);

    }else if (index == _currentPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans =_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0);
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currentPageValue.floor() - 1) {
      var currScale = 1-(_currentPageValue - index) * (1 - _scaleFactor); 
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0);
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)..setTranslationRaw(0, currTrans, 0);
    
    }else{
      var currScale=0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Diementions.pageViewContainer * 1.2,
            margin: EdgeInsets.only(left: Diementions.width10, right: Diementions.width10),
            decoration: BoxDecoration(
              color: index.isEven?Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/food/food1.jpg'), // Example images
              ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
      
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Diementions.pageViewTextContainer * 1.2,
              margin: EdgeInsets.only(left: Diementions.width20, right: Diementions.width20, bottom: Diementions.height5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Diementions.radius20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-5, 0), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(5, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Diementions.height15, left: Diementions.width15, right: Diementions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Afan Soup"),
                    SizedBox(height: Diementions.height5),
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.textColor,
                          size: Diementions.font14,
                        ),
                        SizedBox(width: Diementions.width10),
                        SmallText(
                          text: "Mama Gracy",
                          color: AppColors.mainColor,
                          size: Diementions.font14,
                        ),
                      ],
                    ),
                    SizedBox(height: Diementions.height10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15) 
                        ),
                        ),
                        SizedBox(width: 10),
                        SmallText(
                          text: "4.5",
                          size: Diementions.font10,
                        ),
                        SizedBox(width: 10),
                        SmallText(
                          text: "1287",
                          size: Diementions.font10,
                        ),
                        SizedBox(width: 10),
                        SmallText(
                          text: "Comments",
                          size: Diementions.font10,
                        ),
                      ],
                    ),
                    SizedBox(height: Diementions.height20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                          color: AppColors.textColor,
                          size: 18.0,
                        ),
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text: "1.7km",
                          iconColor: AppColors.mainColor,
                          color: AppColors.textColor,
                          size: 18.0,
                        ),
                        IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconColor: AppColors.iconColor2,
                          color: AppColors.textColor,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}