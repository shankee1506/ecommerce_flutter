import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {

    final Function onPressed;
    final String imageUrl;
    final String title;
    final String price;
    final String productId;

  const ProductCart({ Key? key, required this.onPressed, required this.imageUrl, required this.title, required this.price, required this.productId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProductPage(productId: productId,)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0)
                            ),
                            height: 350.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 24.0,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 350.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    // ignore: unnecessary_string_interpolations
                                    child: Image.network("$imageUrl",
                                    fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text( title,
                                        style: Constants.regularHeading,),
                        
                                        Text("$price",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          // ignore: deprecated_member_use
                                          color: Theme.of(context).accentColor,
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
  }
}