import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shooping_app/utils/theme.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../model/product_models.dart';
import '../../screens/products_details.dart';
import '../text_utils.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({Key? key}) : super(key: key);

  final controller = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          title: Text('Category items'),
          centerTitle: true,
          backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
        ),
        body: GridView.builder(
            itemCount: controller.productList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.8,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 6.0,
                maxCrossAxisExtent: 200),
            itemBuilder: (context, index) {
              return buildCategoryItems(
                  price: controller.productList[index].price ?? 0.0,
                  image: controller.productList[index].image ?? '',
                  rate: controller.productList[index].rating?.rate ?? 0.0,
                  productId: controller.productList[index].id ?? 0,
                  productModels: controller.productList[index],
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(
                          productModels: controller.productList[index],
                        ));
                  });
            }));
  }

  Widget buildCategoryItems(
      {required String image,
      required double price,
      required double rate,
      required int productId,
      required ProductModels productModels,
      required Function() onTap}) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 10.0,
                blurRadius: 5.0,
              )
            ],
          ),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.manageFavorites(productId);
                        },
                        icon: controller.isFavorites(productId)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                              )),
                    IconButton(
                        onPressed: () {
                          cartController.addProductToCart(productModels);
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ))
                  ],
                );
              }),
              Container(
                width: double.infinity,
                height: 145,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(image),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ $price',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 45,
                      height: 20,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextUtils(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                underLine: TextDecoration.none,
                                text: '$rate'),
                            Icon(
                              Icons.star_border_outlined,
                              color: Colors.white,
                              size: 13,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
