import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  final int selectedtab;
  final Function(int) tabPressed;
   

  const BottomTab({ Key? key, required this.selectedtab, required this.tabPressed }) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  late int _selectedTabs = 0;


  @override
  Widget build(BuildContext context) {
    _selectedTabs =widget.selectedtab;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0)
        ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          spreadRadius: 1.0,
          blurRadius: 30.0,
        ),
      ],
      ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               BottomBtn(
                 imagePath: "assets/images/tab_home.png" ,
                 selected: _selectedTabs == 0 ? true : false,
                 onPressed: (){
                   widget.tabPressed(0);
                 },
               ),
               BottomBtn(
                 imagePath: "assets/images/tab_saved.png",
                 selected: _selectedTabs == 1 ? true : false,
                 onPressed: (){
                  widget.tabPressed(1);
                 },
               ),
               BottomBtn(
                 imagePath: "assets/images/tab_search.png",
                 selected: _selectedTabs == 2 ? true : false,
                 onPressed: (){
                   widget.tabPressed(2);
                 },
               ),
               BottomBtn(
                 imagePath: "assets/images/tab_logout.png",
                 selected: _selectedTabs == 3 ? true : false,
                 onPressed: (){
                   FirebaseAuth.instance.signOut();
                 },
               )
             ],
           ),
         );
  }
}


class BottomBtn extends StatelessWidget {

  final String imagePath;
  final bool selected;
  final VoidCallback onPressed;
  const BottomBtn({ Key? key, required this.imagePath, required this.selected, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    bool _selected = selected;
    // ignore: avoid_unnecessary_containers
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0
        ),
    
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              // ignore: deprecated_member_use
              color: _selected ? Theme.of(context).accentColor : Colors.transparent,
              width: 2.0,
            )
          )
        ),
        child: Image(
          image: AssetImage(
            imagePath),
            width: 22.0,
            height: 22.0,
        ),
      ),
    );
  }
}