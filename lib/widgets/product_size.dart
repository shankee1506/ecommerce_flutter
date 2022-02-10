

import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSizes;
  final Function(String) onSelected;
  const ProductSize({ Key? key, required this.productSizes, required this.onSelected }) : super(key: key);

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {

 int _selected = 0 ; 

  @override
  Widget build(BuildContext context) {
    return Row(
                    children: [
                      for(var i= 0; i <  widget.productSizes.length; i++)
                      GestureDetector(

                        onTap: (){
                          widget.onSelected("${widget.productSizes[i]}");
                          setState(() {
                            _selected = i;
                          });
                        } ,
                        child: Container(
                          width: 42.0,
                          height: 42.0,
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: _selected == i ? Theme.of(context).accentColor : const Color(0xFFDCDCDC),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                      
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                          ),
                          child: Text("${widget.productSizes[i]}",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: _selected == i ? Colors.white : Colors.black,
                          ),
                          ),
                        ),
                      )
                    ],
                  );
  }
}