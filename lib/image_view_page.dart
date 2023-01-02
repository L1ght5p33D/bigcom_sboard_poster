import 'package:flutter/material.dart';
import 'dart:io';
import 'sb_data_entry.dart';

class Image_View_Page extends StatefulWidget {
  Image_View_Page(this.state_paths);
  final List<String> state_paths;
  _Image_View_PageState createState() => _Image_View_PageState();
}

class _Image_View_PageState extends State<Image_View_Page> {

List<Widget>? state_ret_images;

  List<Widget> build_images_from_paths(Size ss){
    List<Widget> ret_images = [];
    widget.state_paths.forEach((String path){
      ret_images.add(

          Container(
              height: ss.height*.5,
              child:Image.file(File(path),fit: BoxFit.cover,)));
    });
    state_ret_images = ret_images;
    return ret_images;
  }

  _continue_post(){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SB_Data_Entry(
      images: state_ret_images!,)
    ));
  }

GlobalKey _scaffoldKey = GlobalKey();
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Container(
        height: ss.height,
        child:ListView(children:
       build_images_from_paths(ss)
      ,),),
      floatingActionButton: FloatingActionButton(
        onPressed: _continue_post,
        tooltip: 'Continue Post',
        child: Icon(Icons.forward),
      ),
    );
  }
}
