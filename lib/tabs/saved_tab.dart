import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                 child: Stack(
                   children: const [
                     Center(
                       child: Text("Saved Page"),
                     ),
                     
                     CustomActionBar(
                       title: "Saved Products",
                       hasBackArrow: false,
                       hasTitle: true,
                       hasBackground: false,
                     ),
                   ],
                 ),

                
    );
  }
}