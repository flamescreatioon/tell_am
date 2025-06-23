import 'package:flutter/material.dart';
import 'package:tell_am/components/Head_text.dart';
import 'package:tell_am/components/big_text.dart';
import 'package:tell_am/utils/colors.dart';
import 'package:tell_am/screens/food_page_body.dart';
import 'package:tell_am/utils/diementions.dart';
import 'package:tell_am/widget/small_text.dart';

class PopularFoodPage extends StatefulWidget {
  const PopularFoodPage({super.key});

  @override
  State<PopularFoodPage> createState() => _PopularFoodPageState();
}

class _PopularFoodPageState extends State<PopularFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Container(
            child:  Container(
              margin:  EdgeInsets.only(top: Diementions.height45 , bottom: Diementions.height15),
              padding:  EdgeInsets.only(left: Diementions.width15, right: Diementions.width15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      HeadText(
                        text: "Nigeria",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          BigText(
                            text: "Lagos", 
                            color: AppColors.black54, 
                          ),

                          Icon(
                            Icons.arrow_drop_down_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Diementions.height45,
                      height: Diementions.height45,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Diementions.radius15),
                      ),
                      child: Icon(Icons.search, color: AppColors.mainWhiteColor, size: Diementions.iconSize24,),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}