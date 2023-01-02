import 'package:flutter/cup'
    'ertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app_gs.dart';
import 'board_data_entry_w.dart';

class SB_Data_Entry extends StatefulWidget {
  SB_Data_Entry({Key? key, this.images}) : super(key: key);
  final List<Widget>? images;
  _SB_Data_EntryState createState() => _SB_Data_EntryState();
}

class _SB_Data_EntryState extends State<SB_Data_Entry> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // List<Widget> build_images_from_paths(Size ss){
  //   List<Widget> build_ims = [];
  //   widget.images_paths.forEach((String ip){
  //     build_ims.add(Container(
  //         height: ss.height*.4,
  //         child:Image.file(File(ip))));
  //   });
  //   return build_ims;
  // }


  bool show_menu = false;

  build_menu(Size ss) {
    return Container(
      height: ss.height * .4,
      child: Column(
        children: <Widget>[
          Container(
            child: Text("1"),
          ),
          Container(
            child: Text("2"),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  show_menu = !show_menu;
                });
              },
              icon: Icon(Icons.dehaze),
            )
          ],
        ),
      ),
      body: Container(
        width: ss.width,
        height: ss.height,
        child: ListView(children: [
          show_menu == true ? build_menu(ss) : Container(),
          Container(
            width: ss.width,
            height: ss.height * .5,
            child: PageView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              children: widget.images!,
            ),
          ),
          // Container(
          //        color:Colors.blueGrey[900]!,
          //        child:
          //     Row(
          //      mainAxisAlignment: MainAxisAlignment.end,
          //      children: <Widget>[
          //
          //
          //        RawMaterialButton(
          //
          //        onPressed: (){
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //   return Camera_W();
          //   }));
          //   },
          //   elevation: 2.0,
          //   fillColor: Colors.blueAccent,
          //   child: Icon(
          //     Icons.add,
          //     size: 24.0,
          //     color: Colors.white,
          //   ),
          //   padding: EdgeInsets.all(15.0),
          //   shape: CircleBorder(),
          // ),
          //
          //    ],)),

          Container(
              child: Board_Data_Entry_W(
            editItem: AGS.state_post_item,
          ))
        ]),
      ),
    ));
  }
}
