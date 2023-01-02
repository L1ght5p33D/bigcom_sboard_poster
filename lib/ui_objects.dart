import 'package:flutter/material.dart';

Color button_border = Colors.white54;
Color button_color = Colors.lightBlueAccent;
Color bubble_button_border = Colors.white;
Color bubble_button_color = Colors.blueGrey[900]!;
// Size ss;

Widget UI_but_rr_b(bubble_text, Size ss, double corner_radius, double width, Color color,Color text_color){

  return

      GestureDetector(
          onTap: (){},
          child:ClipRRect(
            borderRadius: BorderRadius.circular(ss.width*.1),
        child: Container(
          decoration: BoxDecoration(color: button_border ),
          child:
        ClipRRect(
          borderRadius: BorderRadius.circular(ss.width*.1),
          child: Container(
          decoration: BoxDecoration(color: button_color),
          child:
          Center(child:Container(child: Text("Button Text"),))
          ,),)
        ,),));
}

ui_bubble_display(bubble_text, Size ss, double corner_radius, double width, Color color,Color text_color){
  return
    ClipRRect(
      borderRadius: BorderRadius.circular(corner_radius),
      child: Container(
        width: width,
        decoration: BoxDecoration(color: button_border ),
        child:
        ClipRRect(
          borderRadius: BorderRadius.circular(corner_radius),
          child: Container(
            decoration: BoxDecoration(color: color),
            child:
            Center(child:Container(child: Text(bubble_text,style: TextStyle(color: text_color),),))
            ,),)
        ,),);
}